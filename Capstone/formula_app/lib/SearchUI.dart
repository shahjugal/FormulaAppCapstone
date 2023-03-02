import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'SearchResultsUI.dart';

class SearchUI extends StatefulWidget {
  @override
  _SearchUIState createState() => _SearchUIState();
}

class _SearchUIState extends State<SearchUI> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<String> _tags = [
    'Accounting',
    'Aerospace engineering',
    'Agricultural engineering',
    'Anthropology',
    'Architecture',
    'Artificial intelligence',
    'Astrophysics',
    'Biochemistry',
    'Biology',
    'Biomedical engineering',
    'Chemical engineering',
    'Electrical engineering',
    'Electronic engineering',
    'Environmental science',
    'Fashion design',
    'Theater',
    'Transportation engineering',
    'Urban planning',
    'Veterinary medicine',
  ];

  Set<String> _selectedTags = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [],
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            child: Material(
              elevation: 4, // Add some elevation
              // borderRadius: BorderRadius.circular(20.0),
              child: TextField(
                controller: _textFieldController,
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove the border from text field
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SearchResultsUI(title: _textFieldController.text),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: _tags.map((tag) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultsUI(title: tag),
                    ),
                  );
                },
                child: Chip(
                  label: Text(tag),
                  elevation: 4,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
