import 'package:flutter/material.dart';

import 'FormulaListUI.dart';

class SubjectsUI extends StatelessWidget {
  final List<String> subjects = [
    'Thermodynamics',
    'Mechanics of Materials',
    'Machine Design',
    'Fluid Mechanics',
    'Dynamics and Control',
    'Manufacturing Processes',
    'Heat Transfer'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subjects',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[900],
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              elevation: 4.0,
              color: Colors.grey[800],
              child: ListTile(
                title: Text(
                  subjects[index],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormulaListUI(),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
