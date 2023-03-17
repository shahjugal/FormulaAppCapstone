import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

class FormulaDetailsScreen extends StatefulWidget {
  final String name;
  final String description;
  final String formula;
  final String applications;
  final List<String> links;
  final String relatedCourses;

  final String tags;

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
  State<FormulaDetailsScreen> createState() => _FormulaDetailsScreenState();
}

class _FormulaDetailsScreenState extends State<FormulaDetailsScreen> {
  final _bookmarkBox = Hive.box('bookmark_box');

  Future _createBookmark(Map<String, dynamic> newBookmark) async {
    await _bookmarkBox.add(newBookmark);
    //  _refreshBookmark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border_outlined),
            onPressed: () async {
              _createBookmark({
                "name": widget.name,
                "description": widget.description,
                "formula": widget.formula,
                "applications": widget.applications,
                "links": widget.links,
                "relatedcourses": widget.relatedCourses,
                "tags": widget.tags
              });
              final msg = SnackBar(
                content: Text('Formula added to Bookmarks'),
                backgroundColor: Colors.green,
                padding: EdgeInsets.all(20),
              );
              ScaffoldMessenger.of(context).showSnackBar(msg);
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.description),
            const SizedBox(height: 16.0),
            Text(widget.formula),
            const SizedBox(height: 16.0),
            const Text(
              'Applications:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ((widget.applications).split(';'))
                  .map(
                    (app) => Text(
                      ('• ' + (' $app').trim()),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Links:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 80.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.links.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 100.0,
                      child: Card(
                        child: Center(
                          child: Text(widget.links[index].trim()),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Related Courses:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: (widget.relatedCourses.split(';'))
                  .map((course) => Chip(label: Text((course).trim())))
                  .toList(),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Tags:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: (widget.tags.split(';'))
                  .map((tag) => Chip(label: Text(tag.trim())))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
