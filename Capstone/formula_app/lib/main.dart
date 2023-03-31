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
        // Define the default brightness and colors.
        primaryColor: Color.fromRGBO(128, 18, 20, 1),

        // Define the default font family.
        fontFamily: 'Georgia',
      ),
      home: TabSelectorUI(),
      routes: {
        TabSelectorUI.routeName: (context) => TabSelectorUI(),
      },
    );
  }
}
