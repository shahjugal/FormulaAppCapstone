import 'package:flutter/material.dart';

class FormulaDetailsScreen extends StatelessWidget {
  final String name;
  final String description;
  final String formula;
  final List<String> applications;
  final List<String> links;
  final List<String> relatedCourses;
  final List<String> tags;

  FormulaDetailsScreen({
    required this.name,
    required this.description,
    required this.formula,
    required this.applications,
    required this.links,
    required this.relatedCourses,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            SizedBox(height: 16.0),
            Text(formula),
            SizedBox(height: 16.0),
            Text(
              'Applications:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: applications
                  .map(
                    (app) => Text(
                      ('• ' + (' $app').trim()),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Links:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            SizedBox(
              height: 80.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: links.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 100.0,
                      child: Card(
                        child: Center(
                          child: Text(links[index].trim()),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Related Courses:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: relatedCourses
                  .map((course) => Chip(label: Text((course).trim())))
                  .toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Tags:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children:
                  tags.map((tag) => Chip(label: Text(tag.trim()))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
