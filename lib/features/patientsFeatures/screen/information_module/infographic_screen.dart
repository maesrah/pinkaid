import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/patientsFeatures/screen/information_module/infographic_details_page.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class InfographicScreen extends StatelessWidget {
  const InfographicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> healthItems = [
  {'image': 'assets/icons/symptoms.png', 'title': 'Breast Cancer Symptom'},
  {'image': 'assets/icons/predict.png', 'title': 'Breast Cancer Risk Factor'},
  {'image': 'assets/icons/robotic-surgery.png', 'title': 'Breast Cancer Surgery'},
  {'image': 'assets/icons/breast.png', 'title': 'Breast Reconstruction'},
  {'image': 'assets/icons/medical.png', 'title': 'Chemotherapy'},
  {'image':'assets/icons/pink-ribbon.png', 'title': 'About us'},
  // Add more items as needed
];
    return const Scaffold(body: SingleChildScrollView(child: Padding(
      padding: EdgeInsets.all(kSpaceScreenPadding),
      child: const Column(
        children: [
           SizedBox(
      height: 70,
      child: GraphicCard(),
    ),
    
        ],
      ),
    ),),);
  }
}

class GraphicCard extends StatelessWidget {
  const GraphicCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>InfographicDetailsPage());
      },
      child: Row(
        children: [
          Image.asset('assets/stats/breast1.png'),
          const SizedBox(width: kSpaceScreenPadding,),
          Expanded(
            child: Text('Breast Lump',maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: KTextTheme.lightTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}