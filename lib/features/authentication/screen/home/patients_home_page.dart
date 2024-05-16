import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            onPressed: () {}, icon: const Icon(CupertinoIcons.profile_circled)),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   unselectedFontSize: 4,
      //   iconSize: 4,
      //   selectedFontSize: 4,
      //   items: [
      //     // BottomNavigationBarItem(
      //     //     icon: Icon(Icons.home), label: S.of(context).homeLabel),
      //     // BottomNavigationBarItem(
      //     //     icon: Icon(CupertinoIcons.chat_bubble_2),
      //     //     label: S.of(context).forumLabel),
      //     // BottomNavigationBarItem(
      //     //     icon: Icon(CupertinoIcons.chart_bar_alt_fill),
      //     //     label: S.of(context).trendLabel),
      //     // BottomNavigationBarItem(
      //     //     icon: Icon(CupertinoIcons.square_favorites_alt),
      //     //     label: S.of(context).consultationLabel),
      //     // BottomNavigationBarItem(
      //     //     icon: Icon(CupertinoIcons.profile_circled),
      //     //     label: S.of(context).profileLabel),
      //   ],
      // ),
    );
  }
}
