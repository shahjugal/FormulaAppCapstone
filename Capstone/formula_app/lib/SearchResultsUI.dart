import 'package:flutter/material.dart';
import 'formuladetailsscreen.dart';

class SearchResultsUI extends StatefulWidget {
  final String title;

  const SearchResultsUI({Key? key, required this.title}) : super(key: key);

  @override
  State<SearchResultsUI> createState() => _SearchResultsUIState();
}

class _SearchResultsUIState extends State<SearchResultsUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search results for " + widget.title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
