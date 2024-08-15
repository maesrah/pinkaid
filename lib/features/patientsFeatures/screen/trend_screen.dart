import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/authentication/screen/profile/addMedication.dart';
import 'package:pinkaid/features/authentication/screen/profile/updateUserProfile.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/utils/constant/colors.dart';

class HealthTrendPage extends StatefulWidget {
  const HealthTrendPage({super.key});

  @override
  _HealthTrendPageState createState() => _HealthTrendPageState();
}

class _HealthTrendPageState extends State<HealthTrendPage> {
 

  @override
  Widget build(BuildContext context) {
    const List<Color> kColorPrimaryList = [Colors.blue, Colors.green];
    List<PieChartSectionData> showingSections() {
      return List.generate(
        2,
        (i) {
          var color0 = kColorSecondary;

          switch (i) {
            case 0:
              return PieChartSectionData(
                  color: color0,
                  value: 33,
                  title: '',
                  radius: 55,
                  titlePositionPercentageOffset: 0.55,
                  badgeWidget: const Text(
                    "20,1",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ));
            case 1:
              return PieChartSectionData(
                color: Colors.white,
                value: 75,
                title: '',
                radius: 45,
                titlePositionPercentageOffset: 0.55,
              );

            default:
              throw Error();
          }
        },
      );
    }

//     void _openIconButtonPressed(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) => Container(
//       width: MediaQuery.of(context).size.width,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding,vertical: kSpaceScreenPadding),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Symptom',style: KTextTheme.lightTextTheme.headlineMedium,),
//           SizedBox(height: kSpaceScreenPadding,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Tender breast',style: KTextTheme.lightTextTheme.headlineSmall,)
              

//             ],
//           )

//         ],
//             ),
//       )),
//   );
// }
void _openSymptom(BuildContext context) {
  int? _currentIndex;
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPaddingLg, vertical: kSpaceScreenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Symptom',
              style: KTextTheme.lightTextTheme.headlineMedium,
            ),
            const SizedBox(height: kSpaceScreenPadding),
            SymptomBox(currentIndex: _currentIndex, nameSymptom: 'Tender breast',),
            const SizedBox(height: 10,),
            SymptomBox(currentIndex: _currentIndex, nameSymptom: 'Lump on breast',),
            const SizedBox(height: kSpaceScreenPadding),
            SymptomBox(currentIndex: _currentIndex, nameSymptom: 'Backpain',),
            const SizedBox(height: 10,),
            SymptomBox(currentIndex: _currentIndex, nameSymptom: 'Fatigue',),
            const SizedBox(height: kSpaceScreenPadding),
           Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  // Define the edit action here
                  print('Edit button pressed');
                },
                child: const Text('Add/Edit'),
              ),
            ),
            
          ],
        ),
      ),
    ),
  );
}

void _openNutrition(BuildContext context) {
  int? _currentIndex;
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPaddingLg, vertical: kSpaceScreenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nutrition',
              style: KTextTheme.lightTextTheme.headlineMedium,
            ),
            const SizedBox(height: kSpaceScreenPadding),
            const Text('Nutrition suggestion'),
           Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  // Define the edit action here
                  print('Edit button pressed');
                },
                child: const Text('Add/Edit'),
              ),
            ),
            
          ],
        ),
      ),
    ),
  );
}

void _openMedication(BuildContext context) {
  int? _currentIndex;
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPaddingLg, vertical: kSpaceScreenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medication',
              style: KTextTheme.lightTextTheme.headlineMedium,
            ),
            const SizedBox(height: kSpaceScreenPadding),
            const Text('Nutrition suggestion'),
           Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  // Define the edit action here
                  print('Edit button pressed');
                },
                child: const Text('Add/Edit'),
              ),
            ),
            
          ],
        ),
      ),
    ),
  );
}



    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: kColorPrimaryList),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.075),
                  ),
                  child: Stack(alignment: Alignment.center, children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "BMI (Body Mass Index)",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "You have a normal weight",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 12),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width *
                                    0.05,
                              ),
                              
                            ],
                          ),
                          AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback: (FlTouchEvent event,
                                      pieTouchResponse) {},
                                ),
                                startDegreeOffset: 250,
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 1,
                                centerSpaceRadius: 0,
                                sections: showingSections(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     Expanded(
                       child: Container(
                         padding: const EdgeInsets.symmetric(
                             horizontal: kSpaceScreenPadding,
                             vertical: kSpaceScreenPadding),
                         decoration: BoxDecoration(
                             color: kColorSecondaryLight,
                             borderRadius: BorderRadius.circular(16)),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                            
                             GestureDetector(
                              onTap: (){
                                 showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Update Weight' ),
                                      content: const TextField(
                                        //controller: _controller,
                                        decoration: InputDecoration(
                                          hintText: 'Enter new weight'
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // if (_controller.text.isNotEmpty) {
                                            //   userController.updateUserData(field, _controller.text, userId);
                                            //   Get.back();
                                            // }
                                          },
                                          child: const Text('Update'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                               child: Text(
                                 'Current Weight:',
                                 style: KTextTheme.lightTextTheme.titleSmall,
                               ),
                             ),
                             Text(
                               '57 kg',
                               style: KTextTheme.lightTextTheme.headlineLarge,
                             )
                           ],
                         ),
                       ),
                     ),
                     const SizedBox(
                       width: 10,
                     ),
                     Expanded(
                       child: GestureDetector(
                        onTap: (){
                          showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Update height' ),
                                      content: const TextField(
                                        //controller: _controller,
                                        decoration: InputDecoration(
                                          hintText: 'Enter new height'
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // if (_controller.text.isNotEmpty) {
                                            //   userController.updateUserData(field, _controller.text, userId);
                                            //   Get.back();
                                            // }
                                          },
                                          child: const Text('Update'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              
                        },
                         child: Container(
                           padding: const EdgeInsets.symmetric(
                               horizontal: kSpaceScreenPadding,
                               vertical: kSpaceScreenPadding),
                           decoration: BoxDecoration(
                               color: kColorInfo,
                               borderRadius: BorderRadius.circular(16)),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                              
                               Text(
                                 'Height:',
                                 style: KTextTheme.lightTextTheme.titleSmall,
                               ),
                               Text(
                                 '160 cm',
                                 style: KTextTheme.lightTextTheme.headlineLarge,
                               )
                               
                               
                             ],
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
                 const SizedBox(height: kSpaceScreenPadding,),
                 Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: kColorInfo,borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding,vertical: kSpaceScreenPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Log your symptom',style: KTextTheme.lightTextTheme.bodyMedium,),
                        IconButton(onPressed: () {
                          _openSymptom(context);
                        },icon: const Icon(Iconsax.add_circle_copy), 
                        ),
                      ],
                    ),
                  ),
                 ),
                 const SizedBox(height: kSpaceScreenPadding,),
                 Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: kColorInfo,borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding,vertical: kSpaceScreenPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Add your nutrition',style: KTextTheme.lightTextTheme.bodyMedium,),
                        IconButton(onPressed: () {
                           _openNutrition(context);
                        },icon: const Icon(Iconsax.add_circle_copy), 
                        ),
                      ],
                    ),
                  ),
                 ),
                 const SizedBox(height: kSpaceScreenPadding,),
                 Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: kColorInfo,borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding,vertical: kSpaceScreenPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Medication?',style: KTextTheme.lightTextTheme.bodyMedium,),
                        IconButton(onPressed: () {
                           Get.dialog(AddMedication(userId: '1',
                      
                      ));
                        },icon: const Icon(Iconsax.add_circle_copy), 
                        ),
                      ],
                    ),
                  ),
                 ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [TextButton.icon(onPressed: (){}, label: const Text('View your insights'),icon: const Icon(Iconsax.arrow_right_copy),)],)


                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SymptomBox extends StatelessWidget {
  const SymptomBox({
    super.key,
    required int? currentIndex,
    required this.nameSymptom,
  }) : _currentIndex = currentIndex;

  final int? _currentIndex;
  final String nameSymptom;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        //crossAxisAlignment: cro,
        children: [
          Text(
            nameSymptom,
            style: KTextTheme.lightTextTheme.bodySmall,
            maxLines: 2,
          ),
          SizedBox(
            width: 200,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 1.0,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    
                  },
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _currentIndex == index ? Colors.white : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: _currentIndex == index ? kColorPrimary : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _currentIndex == index ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
