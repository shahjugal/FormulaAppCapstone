import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bookmark_details.dart';

class BookmarkList extends StatefulWidget {
  @override
  State<BookmarkList> createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  final _bookmarkBox = Hive.box('bookmark_box');

  List<Map<String, dynamic>> _items = [];

  void _refreshBookmark() {
    final data = _bookmarkBox.keys.map((key) {
      final item = _bookmarkBox.get(key);
      // print("key ==== ${key}");
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

  @override
  void initState() {
    super.initState();
    _refreshBookmark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (_, index) {
          final currentItem = _items[index];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookmarkDetailsScreen(
                      name: currentItem['name'],
                      description: currentItem['description'],
                      formula: currentItem['formula'],
                      applications: currentItem['applications'],
                      links: currentItem['links'],
                      relatedCourses: currentItem['relatedcourses'],
                      tags: currentItem['tags'],
                    ),
                  ),
                );
              },
              title: Text(currentItem['name']),
            ),
          );
        },
      ),
    );
  }
}
