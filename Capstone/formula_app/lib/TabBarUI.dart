import 'package:flutter/material.dart';
import 'package:formula_app/SchoolsUI.dart';
import 'BookMarksUI.dart';
import 'SearchUI.dart';
import 'Settings.dart';

class TabSelectorUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabSelectorUIState();
}

class _TabSelectorUIState extends State<TabSelectorUI> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    SchoolUI(),
    SearchUI(),
    BookMarksUI(),
    SettingsUI(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => _children[_currentIndex],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavigationBar(
                elevation: 25,
                enableFeedback: true,
                type: BottomNavigationBarType.shifting,
                selectedItemColor: Theme.of(context).primaryColor,
                selectedIconTheme:
                    IconThemeData(color: Theme.of(context).primaryColor),
                unselectedIconTheme:
                    IconThemeData(color: Theme.of(context).disabledColor),
                onTap: onTabTapped,
                currentIndex: _currentIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search_outlined,
                    ),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.bookmark_border,
                    ),
                    label: "Saved",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings_outlined,
                    ),
                    label: "Updates",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
