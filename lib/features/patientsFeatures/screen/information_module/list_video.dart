import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/patientsFeatures/screen/information_module/details_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/information_module/video_screen.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class ListVideoScreen
 extends StatelessWidget {
  const ListVideoScreen
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(kSpaceScreenPadding),
          child: Column(
            children: [
              InfoCard(image: 'assets/stats/selfexam.jpg', title: 'Breast Cancer Self Examination',videoUrl: '',)
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.image,
    required this.title,
    required this.videoUrl
  });

  final String image;
  final String title;
  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to( InfoDetailsPage(image: image, title: title, videoUrl: videoUrl,));
      },
      child: SizedBox(
        height: 70,
        child: Row(
          children: [
            // Image.asset('assets/video/tumbnail.png'),
             Image.asset(image),
            const SizedBox(width: kSpaceScreenPadding,),
            Expanded(
              child: Text(title,maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: KTextTheme.lightTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}