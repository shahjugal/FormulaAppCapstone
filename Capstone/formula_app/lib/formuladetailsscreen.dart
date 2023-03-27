import 'package:flutter/material.dart';
import 'package:formula_app/FormulaListUI.dart';
import 'package:formula_app/bookmark_list.dart';

import 'package:hive_flutter/hive_flutter.dart';

class FormulaDetailsScreen extends StatefulWidget {
  final String name;
  final String description;
  // final String formula;
  final String applications;
  final List<String> links;
  // final String relatedCourses;
  final String formulaurl;
  final String parameterurl;
  final String physical;

  final String tags;

  FormulaDetailsScreen({
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
  State<FormulaDetailsScreen> createState() => _FormulaDetailsScreenState();
}

class _FormulaDetailsScreenState extends State<FormulaDetailsScreen> {
  final _bookmarkBox = Hive.box('bookmark_box');

  Future _createBookmark(Map<String, dynamic> newBookmark) async {
    // final data = _bookmarkBox.values.contains(widget.name);

    // final gasPlanets = <int, String>{1: 'Jupiter', 2: 'Saturn'};

    // print(" ==== _createBookmark newBookmark === ${newBookmark}");
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
              if ((_bookmarkBox.values
                      .where((element) => element['name'] == widget.name)
                      .toList()
                      .length) >
                  0) {
                final msg = SnackBar(
                  content: Text('Bookmark already added'),
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.all(20),
                );
                ScaffoldMessenger.of(context).showSnackBar(msg);
              } else {
                _createBookmark({
                  "name": widget.name,
                  "description": widget.description,
                  "applications": widget.applications,
                  "links": widget.links,
                  "tags": widget.tags,
                  "formulaurl": widget.formulaurl,
                  "parameterurl": widget.parameterurl,
                  "physical": widget.physical,
                });
                final msg = SnackBar(
                  content: Text('Formula added to Bookmarks'),
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.all(20),
                );
                BookmarkList().createState().Refresh();
                ScaffoldMessenger.of(context).showSnackBar(msg);
              }
              // print(" ==== create bookmark === ${widget.parameterurl}");
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
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1)),
              child: widget.formulaurl != null
                  ? ClipRRect(
                      child: Image.network(
                        widget.formulaurl,
                        fit: BoxFit.cover,
                      ), //Text("No image selected"),
                    )
                  : const Center(
                      child: Text('No image added'),
                    ),
            ),
            // ======== Parameter URL ========= //
            const SizedBox(height: 16.0),
            const Text(
              'Paramters:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1)),
              child: widget.parameterurl != null
                  ? ClipRRect(
                      child: Image.network(
                        widget.parameterurl,
                        fit: BoxFit.fill,
                      ), //Text("No image selected"),
                    )
                  : const Center(
                      child: Text('No image added'),
                    ),
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
                      ('• ' + (' $app').trim()),
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
