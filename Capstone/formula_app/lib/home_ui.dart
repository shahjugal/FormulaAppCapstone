import 'package:flutter/material.dart';
import 'subjects_ui.dart';

class HomeUI extends StatelessWidget {
  final List<String> engineeringStreams = [
    'Civil Engineering',
    'Mechanical Engineering',
    'Electrical Engineering',
    'Electronics and Communication Engineering',
    'Computer Science and Engineering',
    'Information Technology Engineering',
    'Aerospace Engineering',
    'Chemical Engineering',
    'Biomedical Engineering',
    'Environmental Engineering',
    'Petroleum Engineering',
    'Marine Engineering',
    'Nuclear Engineering',
    'Mining Engineering',
    'Industrial Engineering',
    'Material Science and Engineering',
    'Automobile Engineering',
    'Instrumentation Engineering',
    'Production Engineering',
    'Textile Engineering',
    'Agricultural Engineering',
    'Architecture and Planning',
    'Geo-informatics Engineering',
    'Food Technology',
    'Power Engineering',
    'Naval Architecture and Ocean Engineering'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Engineering Streams',
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // number of columns
          childAspectRatio: 1.2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: engineeringStreams.map((stream) {
            return GestureDetector(
              onTap: () {
                // navigate to subjects UI when stream is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectsUI(),
                  ),
                );
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.grey[800],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.engineering,
                      size: 50.0,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      stream,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
