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
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.list)),
            Tab(icon: Icon(Icons.search)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Scaffold for tab1
          SchoolUI(),
          // Scaffold for tab2
          SearchUI(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
