import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pinkaid/features/patientsFeatures/controller/trend_controller.dart';

Map<String, int> getExerciseForWeek(Map<String, dynamic> dailyTracking) {
  Map<String, int> exerciseMinutes = {};

  DateTime now = DateTime.now();
  DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday
  DateTime endOfWeek = startOfWeek.add(const Duration(days: 6)); // Sunday

  // Loop through each day of the week
  for (DateTime day = startOfWeek;
      day.isBefore(endOfWeek.add(const Duration(days: 1)));
      day = day.add(const Duration(days: 1))) {
    String formattedDate = DateFormat('dd-MM-yy').format(day);

    int totalMinutes = 0;

    // Check if daily exercise entry exists
    if (dailyTracking.containsKey(formattedDate)) {
      var exerciseData = dailyTracking[formattedDate]?['dailyExercises'];

      // Check if the 'dailyExercises' is a list
      if (exerciseData is List) {
        // Loop through the array of exercises
        for (var exerciseEntry in exerciseData) {
          if (exerciseEntry['minutes'] != null &&
              exerciseEntry['minutes'] is int &&
              exerciseEntry['minutes'] >= 0) {
            totalMinutes += exerciseEntry['minutes'] as int;
          }
        }
      } else {
        print('Error: dailyExercises is not a List');
      }
    }

    // Store total exercise minutes for the day
    exerciseMinutes[formattedDate] = totalMinutes;
  }

  return exerciseMinutes;
}




class BarChartSample2 extends StatelessWidget {
  BarChartSample2({super.key});

  final TrendController exerciseController =
      Get.put(TrendController()); // GetX Controller

  final Color barBackgroundColor = Colors.blue.withOpacity(0.3);
  final Color barColor = Colors.blue;
  final Color touchedBarColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    Map<String, int> exerciseData =
        getExerciseForWeek(exerciseController.patient.value.dailyTracking);

    return Obx(() {
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
                      'Exercise Duration Chart (Minutes)',
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
                          mainBarData(exerciseData), 
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
          ));
    });
  }





  List<BarChartGroupData> showingGroups(Map<String, int> exerciseData) {
    return List.generate(7, (i) {
      String dayOfWeek = DateFormat('dd-MM-yy').format(
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1 - i)),
      );

      double minutes = exerciseData[dayOfWeek]?.toDouble() ?? 0;

      return makeGroupData(
        i,
        minutes,
        isTouched: i == exerciseController.exerciseTouchedBar.value,
      );
    });
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
            toY: 1,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
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
  // Use the mainBarData method with exerciseData instead of caloriesData
  BarChartData mainBarData(Map<String, int> exerciseData) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
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
          if (!event.isInterestedForInteractions ||
              barTouchResponse == null ||
              barTouchResponse.spot == null) {
            exerciseController.exerciseTouchedBar.value = -1;
            return;
          }
          exerciseController.exerciseTouchedBar.value =
              barTouchResponse.spot!.touchedBarGroupIndex;
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
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(exerciseData),
      gridData: const FlGridData(show: false),
    );
  }
}

