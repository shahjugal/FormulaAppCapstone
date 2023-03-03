import 'package:flutter/material.dart';
import 'package:formula_app/SchoolsUI.dart';

import 'SearchUI.dart';

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
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: [
          Tab(icon: Icon(Icons.list, color: Theme.of(context).primaryColor)),
          Tab(
              icon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          )),
        ],
        labelColor: Theme.of(context).primaryColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Theme.of(context).primaryColor,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
