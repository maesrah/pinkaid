import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class InfographicDetailsPage extends StatelessWidget {
  const InfographicDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_circle_left_copy),
        ),
        title: Text(
          'Breast Lump',
          style: KTextTheme.lightTextTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/stats/breast1.png'),
            const SizedBox(height: kSpaceScreenPadding,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Did you know?',style: KTextTheme.lightTextTheme.headlineSmall,),
                  const SizedBox(height: kSpaceSectionSm,),
                   Image.asset('assets/stats/breast2.png'),
                   SizedBox(height: kSpaceScreenPadding,),
                   Text('The commonest symptom is usually breast lump',style: KTextTheme.lightTextTheme.titleSmall,),
                   SizedBox(height: 6,),
                   Text('Other symptoms included nipple discharge, nipple retraction,skin redness/ thickening/ dimpling or presence of axillary lymph nodes swelling (swelling underneath the armpit)'),
                   SizedBox(height: kSpaceSectionSm,),
                   Text('Do get early medical attention if you notice any!',style: KTextTheme.lightTextTheme.titleSmall,),
                  
                ],
              ),
              
            ),
            
           

          ],
        ),
      ),);
  }
}



class InfographicBreastDetailsPage extends StatelessWidget {
  const InfographicBreastDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_circle_left_copy),
        ),
        title: Text(
          'Breast Lump',
          style: KTextTheme.lightTextTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/stats/breast1.png'),
            const SizedBox(height: kSpaceScreenPadding,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Did you know?',style: KTextTheme.lightTextTheme.headlineSmall,),
                  const SizedBox(height: kSpaceSectionSm,),
                   Image.asset('assets/stats/breast2.png'),
                   Image.asset('assets/stats/breast3.png'),
             
                  
                ],
              ),
              
            ),
            
           

          ],
        ),
      ),);
  }
}