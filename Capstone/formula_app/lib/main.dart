import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'ImageScreen.dart';
import 'TabBarUI.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

late Box box;

Future<bool> checkInternetConnectivity() async {
  try {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();

  await Hive.openBox('bookmark_box');

  bool connected = await checkInternetConnectivity();

  if (!connected) {
    runApp(const NetErrorScreen());
  } else {
    runApp(MyApp());
  }
}

class NetErrorScreen extends StatelessWidget {
  const NetErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Icon(
            CupertinoIcons.antenna_radiowaves_left_right,
            color: Colors.red,
            size: 200,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Network Error",
              style: TextStyle(fontSize: 20, color: Colors.red)),
          SizedBox(
            height: 10,
          ),
          Text("Check your internet and relaunch app",
              style: TextStyle(fontSize: 10, color: Colors.red)),
          SizedBox(
            height: 50,
          ),
          Text("If Issue persists contact us.",
              style: TextStyle(fontSize: 10, color: Colors.red)),
        ],
      ),
    ));
  }
}

class MyApp extends StatelessWidget {
  final imageUrls = [
    'https://ahduni.edu.in/site/templates/images/media-photo21.jpg',
    'https://ahduni.edu.in/site/templates/images/media-photo22.jpg',
    'https://ahduni.edu.in/site/templates/images/media-photo23.jpg',
    'https://ahduni.edu.in/site/templates/images/media-photo24.jpg'
  ];

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AU Formula eBook',
      theme: ThemeData(
        // Define the default brightness and colors.
        primaryColor: const Color.fromRGBO(128, 18, 20, 1),
      ),
      home: const ImageScreen(
        imageUrl:
            'https://ahduni.edu.in/site/assets/files/1/default_logo_final_png.png',
        // 'https://www.theplan.it/cdn-cgi/image/fit=contain,width=830/images/409.jpg',
      ),
      routes: {
        TabSelectorUI.routeName: (context) => const TabSelectorUI(),
      },
    );
  }
}
