import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BookMarksUI extends StatefulWidget {
  const BookMarksUI({super.key});

  @override
  State<BookMarksUI> createState() => _BookMarksUIState();
}

class _BookMarksUIState extends State<BookMarksUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("You have no formulas bookmarked at the moment."),
      ),
    );
  }
}
