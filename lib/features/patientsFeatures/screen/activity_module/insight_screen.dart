import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pinkaid/features/patientsFeatures/controller/trend_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrendController());
    Map<String, int> symptomFrequency =
        getSymptomFrequencyForMonth(controller.patient.value.dailyTracking);
    Map<String, int> sleepFrequency =
        getSleepFrequencyForWeek(controller.patient.value.dailyTracking);
    List<FlSpot> sleepSpots = convertToFlSpots(sleepFrequency);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Weekly Report',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: kSpaceScreenPadding,
                  ),
                  Text(
                    'Symptom Frequency',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: kSpaceScreenPaddingLg,
                  ),
                  SizedBox(
                    height: 200,
                    child: symptomFrequency.isEmpty
                        ? const Center(
                            child: Text('No symptoms recorded this month.'))
                        : buildSymptomFrequencyChart(symptomFrequency),
                  ),
                  const SizedBox(
                    height: kSpaceScreenPaddingLg,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sleep Hours Frequency',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: kSpaceScreenPaddingLg,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: AspectRatio(
                      aspectRatio: 1.50,
                      child: SizedBox(
                        width: 100,
                        child: LineChart(
                          _mainData(sleepSpots),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kSpaceScreenPadding,
                  ),
                  BarChartSample1(),
                ])),
      ),
    );
  }
}

Widget buildSymptomFrequencyChart(Map<String, int> symptomFrequency) {
  List<BarChartGroupData> barGroups = [];

  for (int i = 0; i < symptomFrequency.length; i++) {
    barGroups.add(BarChartGroupData(
      x: i,
      barRods: [],
    ));
  }

  // Add each symptom's frequency to the corresponding bar group
  int index = 0;
  symptomFrequency.forEach((symptom, frequency) {
    if (frequency > 0) {
      // Only add bars for non-zero frequencies
      barGroups[index].barRods.add(
            BarChartRodData(
              toY: frequency.toDouble(),
              color: kColorPrimary,
              width: 15,
            ),
          );
    } else {
      barGroups[index].barRods.add(
            BarChartRodData(
              toY: 0, // Ensure toY is 0 for zero frequencies
              color: kColorPrimary, // Use transparent color for clarity
              width: 15,
            ),
          );
    }
    index++;
  });

  return BarChart(
    BarChartData(
        minY: 0,
        maxY: 10,
        barGroups: barGroups,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            // tooltipBgColor: Colors.blueAccent, // Background color of the tooltip
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String symptomName = symptomFrequency.keys.elementAt(groupIndex);
              String frequency =
                  rod.toY.toString(); // Get frequency value from the bar

              return BarTooltipItem(
                '$symptomName\nFrequency: $frequency',
                const TextStyle(
                    color: Colors.black), // Style for the tooltip text
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          bottomTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              //showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(value.toInt().toString(),
                    style: const TextStyle(color: Colors.black));
              },
            ),
          ),
        ),
        //gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false)),
  );
}

Widget buildSymptomFrequencyPieChart(Map<String, int> symptomFrequency) {
  return PieChart(
    PieChartData(
      sections: symptomFrequency.entries.map((entry) {
        final symptom = entry.key;
        final frequency = entry.value.toDouble();
        return PieChartSectionData(
          value: frequency,
          title: symptom,
          color: Colors.primaries[frequency.toInt() % Colors.primaries.length],
          titleStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        );
      }).toList(),
    ),
  );
}

List<BarChartGroupData> buildStackedBarData(Map<String, int> symptomFrequency) {
  List<BarChartGroupData> barGroups = [];

  // Create an empty bar group for each unique symptom
  for (int i = 0; i < symptomFrequency.length; i++) {
    barGroups.add(BarChartGroupData(
      x: i,
      barRods: [],
    ));
  }

  // Add each symptom's frequency to the corresponding bar group
  int index = 0;
  symptomFrequency.forEach((symptom, frequency) {
    if (frequency > 0) {
      // Only add bars for non-zero frequencies
      barGroups[index].barRods.add(
            BarChartRodData(
              toY: frequency.toDouble(),
              color: Colors.blue,
              width: 15,
            ),
          );
    } else {
      barGroups[index].barRods.add(
            BarChartRodData(
              toY: 0, // Ensure toY is 0 for zero frequencies
              color: Colors.transparent, // Use transparent color for clarity
              width: 15,
            ),
          );
    }
    index++;
  });

  return barGroups;
}

Widget buildSymptomFrequencyBarChart(Map<String, int> symptomFrequency) {
  List<BarChartGroupData> barGroups = buildStackedBarData(symptomFrequency);

  return BarChart(
    BarChartData(
      barGroups: barGroups,
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text(symptomFrequency.keys.elementAt(value.toInt()));
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String symptomName = symptomFrequency.keys.elementAt(groupIndex);
            String frequency = rod.toY.toString();

            return BarTooltipItem(
              '$symptomName\nFrequency: $frequency',
              TextStyle(color: Colors.white),
            );
          },
        ),
      ),
      gridData: FlGridData(show: false), // Optional: Hide grid lines
      borderData: FlBorderData(show: false), // Optional: Hide borders
    ),
  );
}

Map<String, int> getSymptomFrequencyForMonth(
    Map<String, dynamic> dailyTracking) {
  Map<String, int> symptomFrequency = {};

  DateTime now = DateTime.now();
  int currentMonth = now.month;
  int currentYear = now.year;

  // Loop through each day of the month
  for (int day = 1; day <= 31; day++) {
    try {
      // Format the date (dd-MM-yy) to match the keys in dailyTracking
      String formattedDate = DateFormat('dd-MM-yy')
          .format(DateTime(currentYear, currentMonth, day));

      // Get the symptoms for that day (if they exist)
      List<dynamic> dailySymptoms =
          dailyTracking[formattedDate]?['dailySymptom'] ?? [];

      // Update symptom frequency count
      for (var symptom in dailySymptoms) {
        String symptomName = symptom['symptom'];

        if (symptomFrequency.containsKey(symptomName)) {
          symptomFrequency[symptomName] = symptomFrequency[symptomName]! + 1;
        } else {
          symptomFrequency[symptomName] = 1;
        }
      }
    } catch (e) {
      // Handle days that don't exist (e.g., February 30th)
      break;
    }
  }

  return symptomFrequency;
}

Map<String, int> getSleepFrequencyForMonth(Map<String, dynamic> dailyTracking) {
  Map<String, int> sleepFrequency = {};

  DateTime now = DateTime.now();
  int currentMonth = now.month;
  int currentYear = now.year;

  // Loop through each day of the month
  for (int day = 1; day <= 31; day++) {
    try {
      // Format the date (dd-MM-yy) to match the keys in dailyTracking
      String formattedDate = DateFormat('dd-MM-yy')
          .format(DateTime(currentYear, currentMonth, day));

      // Get the sleep hours for that day (if they exist)
      int? sleepHours = dailyTracking[formattedDate]?['sleepHours'];

      // Ensure sleepHours is valid and non-negative
      if (sleepHours != null &&
          sleepHours >= 0 &&
          !sleepHours.isNaN &&
          !sleepHours.isInfinite) {
        sleepFrequency[formattedDate] = sleepHours;
      } else {
        sleepFrequency[formattedDate] = 0; // Default to 0 if data is invalid
      }
    } catch (e) {
      // Handle invalid days (e.g., February 30th)
      break;
    }
  }

  return sleepFrequency;
}

Map<String, int> getSleepFrequencyForWeek(Map<String, dynamic> dailyTracking) {
  Map<String, int> sleepFrequency = {};

  DateTime now = DateTime.now();
  DateTime startOfWeek = now
      .subtract(Duration(days: now.weekday - 1)); // Monday of the current week
  DateTime endOfWeek =
      startOfWeek.add(const Duration(days: 6)); // Sunday of the current week

  // Loop through each day of the week
  for (DateTime day = startOfWeek;
      day.isBefore(endOfWeek.add(const Duration(days: 1)));
      day = day.add(const Duration(days: 1))) {
    // Format the date (dd-MM-yy) to match the keys in dailyTracking
    String formattedDate = DateFormat('dd-MM-yy').format(day);

    // Get the sleep hours for that day (if they exist)
    int? sleepHours = dailyTracking[formattedDate]?['sleepHours'];

    // Ensure sleepHours is valid and non-negative
    if (sleepHours != null && sleepHours >= 0) {
      sleepFrequency[formattedDate] = sleepHours;
    } else {
      sleepFrequency[formattedDate] = 0; // Default to 0 if data is invalid
    }
  }

  return sleepFrequency;
}

LineChartData _mainData(List<FlSpot> sleepData) {
  return LineChartData(
    gridData: FlGridData(
      show: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d).withOpacity(0.3),
          strokeWidth: 0.5,
        );
      },
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: Color(0xff37434d),
          strokeWidth: 0,
        );
      },
    ),
    titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: 1,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(
                color: kColorPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              );
              switch (value.toInt()) {
                case 0:
                  return const Text('Mon', style: style);
                case 1:
                  return const Text('Tue', style: style);
                case 2:
                  return const Text('Wed', style: style);
                case 3:
                  return const Text('Thu', style: style);
                case 4:
                  return const Text('Fri', style: style);
                case 5:
                  return const Text('Sat', style: style);
                case 6:
                  return const Text('Sun', style: style);
                default:
                  return const Text('');
              }
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(
                color: kColorPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              );
              return Text('${value.toInt()}h', style: style);
            },
          ),
        ),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false))),

    borderData: FlBorderData(
      show: true,
      border: Border.all(color: const Color(0xff37434d), width: 1),
    ),
    minX: 0,
    maxX: 6, // Represent 7 days (Monday-Sunday)
    minY: 0,
    maxY: 10, // Assuming max sleep hours is 10 for a smooth graph
    lineBarsData: [
      LineChartBarData(
        spots: sleepData,
        isCurved: true, // Makes the lines smoother
        gradient: const LinearGradient(
          colors: [Color(0xff23b6e6), kColorPrimary],
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              const Color(0xff23b6e6).withOpacity(0.3),
              kColorPrimary.withOpacity(0.3),
            ],
          ),
        ),
      ),
    ],
  );
}

List<FlSpot> convertToFlSpots(Map<String, int> sleepFrequency) {
  List<FlSpot> spots = [];

  sleepFrequency.forEach((date, hours) {
    DateTime parsedDate = DateFormat('dd-MM-yy').parse(date);
    int weekdayIndex = parsedDate.weekday; // Monday = 1, Tuesday = 2, etc.

    // Convert weekdayIndex to 0-based index (i.e., Monday = 0)
    double weekdayValue = (weekdayIndex - 1).toDouble(); // Adjust for 0-based

    // Ensure hours is non-negative before adding to spots
    if (hours > 0) {
      spots.add(FlSpot(weekdayValue, hours.toDouble()));
    } else {
      spots.add(FlSpot(weekdayValue, 0));
    }
  });

  return spots;
}

// Import the CalorieController

Map<String, int> getCaloriesForWeek(Map<String, dynamic> dailyTracking) {
  Map<String, int> calorieCount = {};

  DateTime now = DateTime.now();
  DateTime startOfWeek = now
      .subtract(Duration(days: now.weekday - 1)); // Monday of the current week
  DateTime endOfWeek =
      startOfWeek.add(const Duration(days: 6)); // Sunday of the current week

  // Loop through each day of the week
  for (DateTime day = startOfWeek;
      day.isBefore(endOfWeek.add(const Duration(days: 1)));
      day = day.add(const Duration(days: 1))) {
    // Format the date (dd-MM-yy) to match the keys in dailyTracking
    String formattedDate = DateFormat('dd-MM-yy').format(day);

    int totalCalories = 0; // Initialize total calories for the day

    // Check if the entry for this date exists
    if (dailyTracking.containsKey(formattedDate)) {
      var meals = dailyTracking[formattedDate]?['dailyMeals'];

      if (meals is Map<String, dynamic>) {
        // Loop through each meal type (breakfast, lunch, etc.) and sum the calories
        for (var mealType in meals.keys) {
          List<dynamic> mealList = meals[mealType]; // List of meals

          // Sum calories for each meal entry
          for (var mealEntry in mealList) {
            if (mealEntry['calories'] != null &&
                mealEntry['calories'] is int &&
                mealEntry['calories'] >= 0) {
              totalCalories += mealEntry['calories'] as int;
            }
          }
        }
      } else {
        // Handle the case where 'dailyMeals' is not a Map (or log an error)
        print('Error: dailyMeals is not a Map');
      }
    }

    // Store the total calories for the day in the map
    calorieCount[formattedDate] = totalCalories;
  }

  return calorieCount;
}

class BarChartSample1 extends StatelessWidget {
  BarChartSample1({super.key});

  final TrendController calorieController =
      Get.put(TrendController()); // GetX Controller

 

  final Color barBackgroundColor = Colors.pink.withOpacity(0.3);
  final Color barColor = Colors.pink;
  final Color touchedBarColor = Colors.deepOrange;

  @override
  Widget build(BuildContext context) {
    Map<String, int> caloriesData =
        getCaloriesForWeek(calorieController.patient.value.dailyTracking);

    // Once the data is loaded, display the chart
    return Obx((){
      return AspectRatio(
          aspectRatio: 1.3,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Calorie Consumption Chart',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 38),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: BarChart(
                          mainBarData(
                              caloriesData), 
                          swapAnimationDuration:
                              const Duration(milliseconds: 250),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ));}
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= this.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: touchedBarColor.withOpacity(0.8))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(Map<String, int> caloriesData) {
    // Using calorie data from the controller to create the bar chart groups
    return List.generate(7, (i) {
      String dayOfWeek = DateFormat('dd-MM-yy').format(
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1 - i)),
      );

      
      double calories = caloriesData[dayOfWeek]?.toDouble() ?? 0;

      return makeGroupData(
        i,
        calories,
        isTouched: i==calorieController.touchedBarIndex.value,
      );
    });
  }

  BarChartData mainBarData(Map<String, int> caloriesData) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          // tooltipBgColor: Colors.blueGrey,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Monday';
                break;
              case 1:
                weekDay = 'Tuesday';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3:
                weekDay = 'Thursday';
                break;
              case 4:
                weekDay = 'Friday';
                break;
              case 5:
                weekDay = 'Saturday';
                break;
              case 6:
                weekDay = 'Sunday';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, BarTouchResponse? barTouchResponse) {
    if (!event.isInterestedForInteractions || barTouchResponse == null || barTouchResponse.spot == null) {
      calorieController.touchedBarIndex.value = -1; // Reset if no bar is touched
      return;
    }
    calorieController.touchedBarIndex.value = barTouchResponse.spot!.touchedBarGroupIndex;
  },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(caloriesData),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Mon', style: style);
        break;
      case 1:
        text = const Text('Tue', style: style);
        break;
      case 2:
        text = const Text('Wed', style: style);
        break;
      case 3:
        text = const Text('Thu', style: style);
        break;
      case 4:
        text = const Text('Fri', style: style);
        break;
      case 5:
        text = const Text('Sat', style: style);
        break;
      case 6:
        text = const Text('Sun', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}
