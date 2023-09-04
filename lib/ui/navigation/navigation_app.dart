import 'package:admin_gm/ui/screens/details/news_screen.dart';
import 'package:admin_gm/ui/screens/other/other_screen.dart';
import 'package:admin_gm/ui/screens/settings/setting_screen.dart';
import 'package:flutter/material.dart';

class NavigationApp extends StatefulWidget {
  const NavigationApp({super.key});

  @override
  State<NavigationApp> createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  List pages = [NewsScreen(), OtherScreen(), SettingScreen()];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              label: 'Новости', icon: Icon(Icons.newspaper)),
          BottomNavigationBarItem(
              label: 'Прочее', icon: Icon(Icons.other_houses)),
          // BottomNavigationBarItem(
          //     label: 'Настройки', icon: Icon(Icons.settings))
        ],
      ),
    );
  }
}
