import 'package:flutter/material.dart';
import 'package:formula_app/SchoolsUI.dart';

import 'BookMarksUI.dart';
import 'SearchUI.dart';
import 'Settings.dart';

class TabSelectorUI extends StatefulWidget {
  @override
  _TabSelectorUIState createState() => _TabSelectorUIState();
}

class _TabSelectorUIState extends State<TabSelectorUI>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          // Scaffold for tab1
          SchoolUI(),
          // Scaffold for tab2
          SearchUI(),
          //BookMarksUI(),
          //SettingsUI(),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: [
          Tab(
              icon: Column(
            children: [
              Icon(Icons.home_outlined, color: Theme.of(context).primaryColor),
              SizedBox(
                height: 2,
              ),
              Text("Home", style: TextStyle(fontSize: 12)),
            ],
          )),
          Tab(
              icon: Column(
            children: [
              Icon(Icons.search, color: Theme.of(context).primaryColor),
              SizedBox(
                height: 2,
              ),
              Expanded(
                child: Text(
                  "Search",
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )),
          // Tab(
          //     icon: Column(
          //   children: [
          //     Icon(Icons.bookmark_border_outlined,
          //         color: Theme.of(context).primaryColor),
          //     SizedBox(
          //       height: 2,
          //     ),
          //     Expanded(
          //       child: Text(
          //         "Bookmarks",
          //         style: TextStyle(fontSize: 12),
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //     ),
          //   ],
          // )),
          // Tab(
          //     icon: Column(
          //   children: [
          //     Icon(Icons.settings_outlined,
          //         color: Theme.of(context).primaryColor),
          //     SizedBox(
          //       height: 2,
          //     ),
          //     Expanded(
          //       child: Text(
          //         "Settings",
          //         style: TextStyle(fontSize: 12),
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //     ),
          //   ],
          // )),
        ],
        labelColor: Theme.of(context).primaryColor,
        enableFeedback: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        dividerColor: Theme.of(context).primaryColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.only(top: 5.0),
        indicatorColor: Theme.of(context).primaryColor,
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
