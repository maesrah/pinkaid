import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class PatientsHomePage extends StatelessWidget {
  const PatientsHomePage({super.key});
  static const String routeName = 'PatientsHomePage';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const PatientsHomePage();
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.profile_circled)),
              bottom: PreferredSize(preferredSize: kButtonHeight,),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
            child: Column(
              children: [
                
              ],
            ),
          ),
        ));
  }
}
