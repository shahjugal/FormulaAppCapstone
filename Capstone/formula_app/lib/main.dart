import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'TabBarUI.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late Box box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();

  await Hive.openBox('bookmark_box');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formula App',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: TabSelectorUI(),
      routes: {
        TabSelectorUI.routeName: (context) => TabSelectorUI(),
      },
    );
  }
}
