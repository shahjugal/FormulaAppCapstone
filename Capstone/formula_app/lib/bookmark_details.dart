import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookmarkDetailsScreen extends StatefulWidget {
  final String name;
  final String description;
  final String formula;
  final String applications;
  final List<String> links;
  final String relatedCourses;
  final String tags;

  BookmarkDetailsScreen({
    required this.name,
    required this.description,
    required this.formula,
    required this.applications,
    required this.links,
    required this.relatedCourses,
    required this.tags,
  });

  @override
  State<BookmarkDetailsScreen> createState() => _BookmarkDetailsScreenState();
}

class _BookmarkDetailsScreenState extends State<BookmarkDetailsScreen> {
  final _bookmarkBox = Hive.box('bookmark_box');

  @override
  void initState() {
    super.initState();
    _refreshBookmark();
  }

  List<Map<String, dynamic>> _items = [];

  void _refreshBookmark() {
    final data = _bookmarkBox.keys.map((key) {
      final item = _bookmarkBox.get(key);
      print("related courses ${item["relatedcourses"]}");
      return {
        "key": key,
        "name": item["name"],
        "description": item["description"],
        "formula": item["formula"],
        "applications": item["applications"],
        "links": item["links"],
        "relatedcourses": item["relatedcourses"],
        "tags": item["tags"],
      };
    }).toList();
    setState(() {
      _items = data.reversed.toList();
      // print("item list ===${_items.length}");
    });
  }

  Future _createBookmark(Map<String, dynamic> newBookmark) async {
    await _bookmarkBox.add(newBookmark);
    _refreshBookmark();
    //print("box _refreshBookmark ===== ${_items[3].entries}");
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
