import 'package:first_project_advanced/pressentaion/main/pages/home/view/home_page.dart';
import 'package:first_project_advanced/pressentaion/main/pages/notifcation/notifcation_page.dart';
import 'package:first_project_advanced/pressentaion/main/pages/search/search_page.dart';
import 'package:first_project_advanced/pressentaion/main/pages/setting/setting_page.dart';
import 'package:first_project_advanced/pressentaion/resources/color_manager.dart';
import 'package:first_project_advanced/pressentaion/resources/strings_manager.dart';
import 'package:first_project_advanced/pressentaion/resources/values_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotifcationsPage(),
    SettingsPage(),
  ];
  List<String> titels = const [
   AppStrings.home,
   AppStrings.search,
   AppStrings.notifications,
   AppStrings.settings,

  ];

  var _title = AppStrings.home;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: ColorManager.lightGrey,
            spreadRadius: AppSize.s1,
          )
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(

                icon: Icon(Icons.home_outlined,), label: AppStrings.home ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppStrings.search),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppStrings.notifications),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppStrings.settings),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex =index ;
      _title = titels[index];
    });
  }
}
