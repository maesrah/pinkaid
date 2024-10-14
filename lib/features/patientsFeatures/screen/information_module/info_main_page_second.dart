import 'package:flutter/material.dart';
import 'package:pinkaid/features/patientsFeatures/screen/information_module/list_video.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class InfoMainPageSecond extends StatelessWidget {
  const InfoMainPageSecond({super.key});
  

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> infoCardList = [
  {'title': 'Breast Health Self Examination', 'image': 'assets/stats/selfexam.jpg','videoUrl':'assets/video/video1.mp4'},
  {'title': 'Signs and Symptoms of Breast Cancer', 'image': 'assets/stats/screen1.jpg','videoUrl':''},
  
];
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(S.of(context).bhHub,style: KTextTheme.lightTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
      
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Learn more about breast health and breast cancer',
                        style: KTextTheme.lightTextTheme.bodySmall,
                      ),
                      const SizedBox(height: kSpaceScreenPadding,),
                      const Divider(height: 2,color: Colors.grey,)
                      
                    ],
                  ),
                )),
          ),
          body:  Padding(
        padding: const EdgeInsets.all(kSpaceScreenPadding),
        child: ListView.builder(
          itemCount: infoCardList.length,
          itemBuilder: (context, index) {
            final data = infoCardList[index];
            return Padding(
              padding: const EdgeInsets.only(top: kSpaceScreenPadding),
              child: InfoCard(
                title: data['title'] ?? '',
                image: data['image'] ?? '',
                videoUrl: data['videoUrl']??'',
              ),
            );
          },
        ),
      ),)
    );
       
      
  }
}