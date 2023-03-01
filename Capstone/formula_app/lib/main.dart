import 'package:flutter/material.dart';
import 'SchoolsUI.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schools',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: SchoolUI(),
    );
  }
}
