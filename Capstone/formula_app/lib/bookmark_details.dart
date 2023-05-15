import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'NetworkImageWidget.dart';

class BookmarkDetailsScreen extends StatefulWidget {
  final String name;
  final String description;
  // final String formula;
  final String applications;
  final List<String> links;
  // final String relatedCourses;
  final String tags;
  final String formulaurl;
  final String parameterurl;
  final String physical;

  const BookmarkDetailsScreen({super.key, 
    required this.name,
    required this.description,
    // required this.formula,
    required this.applications,
    required this.links,
    // required this.relatedCourses,
    required this.tags,
    required this.formulaurl,
    required this.parameterurl,
    required this.physical,
  });

  @override
  State<BookmarkDetailsScreen> createState() => _BookmarkDetailsScreenState();
}

class _BookmarkDetailsScreenState extends State<BookmarkDetailsScreen> {
  final _bookmarkBox = Hive.box('bookmark_box');

  String extractDomain(String url) {
    final uri = Uri.parse(url);
    final domain = uri.host;
    final parts = domain.split('.');
    if (parts.length >= 2) {
      return parts[parts.length - 2];
    } else {
      return domain;
    }
  }

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
            // ======== name ========= //
            const Text(
              'Name:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(widget.name),

            // ======== formula URL ========= //
            const SizedBox(height: 16.0),
            const Text(
              'Formula / Equation:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            // Text(widget.formulaurl), //////// -----------------------------------//
            NetworkImageWidget(
              imageUrl: widget.formulaurl,
            ),
            // ======== Parameter URL ========= //
            const SizedBox(height: 16.0),
            const Text(
              'Paramters:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            NetworkImageWidget(
              imageUrl: widget.parameterurl,
            ),

            // ======== Description ========= //
            const SizedBox(height: 16.0),
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(widget.description),

            // ======== Application ========= //
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
                      ('• ${(' $app').trim()}'),
                    ),
                  )
                  .toList(),
            ),

            //========= Physical significance ========//
            const SizedBox(height: 16.0),
            const Text(
              'Physical significance',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(widget.physical),

            // ======== LInks =========== //
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
                    child: GestureDetector(
                      onTap: () async {
                        final Uri url = Uri.parse(widget.links[index].trim());
                        if (!await launchUrl(url)) {
                          const erMsg = SnackBar(
                            content: Text('Error Launching URL!'),
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.all(20),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(erMsg);
                        }
                      },
                      child: Container(
                        child: Chip(
                          avatar: const Icon(Icons.link_outlined),
                          elevation: 10,
                          label: Text(
                            extractDomain(widget.links[index].trim()),
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ======== tags ======= //
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
