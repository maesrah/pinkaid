import 'package:flutter/material.dart';
import 'package:pinkaid/features/patientsFeatures/screen/information_module/infographic_screen.dart';
import 'package:pinkaid/features/patientsFeatures/screen/information_module/list_video.dart';
import 'package:pinkaid/features/patientsFeatures/screen/information_module/video_screen.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
           backgroundColor: kColorPrimaryOne.withOpacity(0.7),
          automaticallyImplyLeading: false,
          title: Text(S.of(context).bhHub,style: KTextTheme.lightTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80),
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
                    const TabBar(
                      indicatorColor: kColorPrimaryLight,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [Tab(text: 'Infographic',),Tab(text: 'Video',)])

                  ],
                ),
              )),
        ),
        body: TabBarView(children: [InfographicScreen(),ListVideoScreen()]),
       
      ),
    );
  }
}