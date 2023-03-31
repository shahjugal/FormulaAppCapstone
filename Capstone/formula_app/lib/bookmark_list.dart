import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bookmark_details.dart';

class BookmarkList extends StatefulWidget {
  static _BookmarkListState? _bookmarkListState;

  static final BookmarkList _singleton = BookmarkList._internal();

  factory BookmarkList() {
    return _singleton;
  }

  BookmarkList._internal();

  @override
  _BookmarkListState createState() {
    _bookmarkListState ??= _BookmarkListState();
    return _bookmarkListState!;
  }
}

class _BookmarkListState extends State<BookmarkList> {
  final _bookmarkBox = Hive.box('bookmark_box');

  List<Map<String, dynamic>> _items = [];

  void Refresh() {
    RefreshBookMark();
    setState(() {});
  }

  void RefreshBookMark() {
    final data = _bookmarkBox.keys.map((key) {
      final item = _bookmarkBox.get(key);
      return {
        "key": key,
        "name": item["name"],
        "description": item["description"],
        "applications": item["applications"],
        "links": item["links"],
        "tags": item["tags"],
        "physical": item["physical"],
        "formulaurl": item["formulaurl"],
        "parameterurl": item["parameterurl"],
      };
    }).toList();
    setState(() {
      _items = data.reversed.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    RefreshBookMark();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
        backgroundColor: Theme.of(context).primaryColor,
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
                      applications: currentItem['applications'],
                      links: currentItem['links'],
                      tags: currentItem['tags'],
                      formulaurl: currentItem['formulaurl'],
                      parameterurl: currentItem['parameterurl'],
                      physical: currentItem['physical'],
                    ),
                  ),
                );
              },
              title: Text(currentItem['name']),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Delete'),
                        content: const Text('Are you sure you want to delete?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('cancle'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() async {
                                await _bookmarkBox.delete(currentItem['key']);

                                Navigator.of(context).pop();

                                RefreshBookMark();
                              });

                              setState(() {});
                            },
                            child: const Text('Delete'),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          );
        },
      ),
    );
  }
}
