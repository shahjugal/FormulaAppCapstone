import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'ImageScreen.dart';
import 'TabBarUI.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

bool isConnected = false;

Future<void> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    await Future.delayed(Duration(seconds: 2));
    print("Network Error!");
    exit(0);
  }
}

late Box box;
void main() async {
  checkInternetConnection();
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
      ),
      home: ImageScreen(
        imageUrl:
            'https://images.edexlive.com/uploads/user/imagelibrary/2019/1/21/original/AU.jpg',
        // 'https://www.theplan.it/cdn-cgi/image/fit=contain,width=830/images/409.jpg',
      ),
      routes: {
        TabSelectorUI.routeName: (context) => TabSelectorUI(),
      },
    );
  }
}
