import 'package:flutter/material.dart';
import 'home_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Engineering Streams',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: HomeUI(),
    );
  }
}
