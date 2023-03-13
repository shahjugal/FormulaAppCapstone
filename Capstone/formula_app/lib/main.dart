import 'package:flutter/material.dart';
import 'package:formula_app/bookmark_list.dart';
import 'package:formula_app/test.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'SchoolsUI.dart';
import 'TabBarUI.dart';
import 'package:firebase_core/firebase_core.dart';
import 'addFormulaDetails.dart';
import 'firebase_options.dart';

late Box box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await Hive.initFlutter();
  // box = await Hive.openBox('testBox');
  // Hive.registerAdapter(BookmarkAdapter());
  // box.put(
  //   'bookmark',
  //   Bookmark(name: 'formula 1', description: 'description'),
  // );
  // box.put(
  //   'bookmark',
  //   Bookmark(name: 'formula 2', description: 'description'),
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formula App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: TabSelectorUI(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    Bookmark book = box.get('bookmark');
    return Column(
      children: [Text('${book.name}')],
    );
  }
}
