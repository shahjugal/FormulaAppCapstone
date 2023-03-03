import 'package:flutter/material.dart';
import 'SchoolsUI.dart';
import 'TabBarUI.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formula App',
      theme: ThemeData(
          primaryColor: Colors.blue,
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 255, 255, 255))),
      home: TabSelectorUI(),
    );
  }
}
