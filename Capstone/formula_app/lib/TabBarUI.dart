import 'package:flutter/material.dart';
import 'package:formula_app/SchoolsUI.dart';
import 'package:formula_app/search_tags.dart';
import 'package:formula_app/search_tags.dart';

import 'Settings.dart';

import 'bookmark_list.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class TabSelectorUI extends StatefulWidget {
  static const routeName = '/TabBarUI';

  @override
  _TabSelectorUIState createState() => _TabSelectorUIState();
}

class _TabSelectorUIState extends State<TabSelectorUI>
    with SingleTickerProviderStateMixin {
  late PersistentTabController _tabController;

  List<Widget> _buildScreens() {
    return [
      SchoolUI(),
      const SearchTags(),
      BookmarkList(),
      SettingsUI(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.bookmark_border_outlined),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.info_sharp),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _tabController = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    // print("args === ${args.items}");
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _tabController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
