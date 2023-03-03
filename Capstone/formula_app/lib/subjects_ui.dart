import 'package:flutter/material.dart';
import 'FormulaListUI.dart';

class SubjectsUI extends StatefulWidget {
  @override
  _SubjectsUIState createState() => _SubjectsUIState();
}

class _SubjectsUIState extends State<SubjectsUI> {
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              elevation: 4.0,
              color: Colors.white,
              child: ListTile(
                title: Text(
                  subjects[index],
                  style: TextStyle(
                    color: Colors.black,
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
