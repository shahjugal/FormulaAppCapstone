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
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  String newSubjectName = '';
                  return AlertDialog(
                    title: Text('New Subject'),
                    content: TextField(
                      onChanged: (value) {
                        newSubjectName = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter subject name',
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('CREATE'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // TODO: create new subject with newSubjectName
                          setState(() {
                            subjects.add(newSubjectName);
                          });
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
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
