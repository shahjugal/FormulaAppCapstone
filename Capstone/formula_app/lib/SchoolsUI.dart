import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formula_app/SearchUI.dart';
import 'package:formula_app/StreamsUI.dart';

class SchoolUI extends StatefulWidget {
  @override
  State<SchoolUI> createState() => _SchoolUIState();
}

class _SchoolUIState extends State<SchoolUI> {
  final List<String> schoolCategories = [
    'Science',
    'Arts',
    'Business',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schools',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // number of columns
          childAspectRatio: 1.2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: schoolCategories.asMap().entries.map((entry) {
            final int index = entry.key;
            final String category = entry.value;
            return GestureDetector(
              onTap: () {
                // navigate to subjects UI when category is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StreamsUI(),
                  ),
                );
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.school,
                        size: 50.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        category,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
