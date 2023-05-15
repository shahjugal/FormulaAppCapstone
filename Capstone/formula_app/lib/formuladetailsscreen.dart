import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:formula_app/FormulaListUI.dart';
import 'package:formula_app/bookmark_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'NetworkImageWidget.dart';

class Report {
  String title;
  String issue;

  Report({required this.title, required this.issue});
}

class FormulaDetailsScreen extends StatefulWidget {
  final String name;
  final String description;
  final String applications;
  final List<String> links;
  final String formulaurl;
  final String parameterurl;
  final String physical;
  final String tags;
  final String schoolDocId;
  final String majorDocId;
  final String courseDocId;
  final String docId;

  FormulaDetailsScreen({
    required this.name,
    required this.description,
    required this.applications,
    required this.links,
    required this.tags,
    required this.formulaurl,
    required this.parameterurl,
    required this.physical,
    required this.courseDocId,
    required this.majorDocId,
    required this.schoolDocId,
    required this.docId,
  });

  @override
  State<FormulaDetailsScreen> createState() => _FormulaDetailsScreenState();
}

class _FormulaDetailsScreenState extends State<FormulaDetailsScreen> {
  final _bookmarkBox = Hive.box('bookmark_box');

  var show = true;
  Future _createBookmark(Map<String, dynamic> newBookmark) async {
    await _bookmarkBox.add(newBookmark);
  }

  bool _isFirstBuild = true;

  void runCount(CollectionReference<Map<String, dynamic>> stream) {
    if (_isFirstBuild) {
      setState(() {
        stream.doc(widget.docId).update({'count': FieldValue.increment(1)});
      });

      _isFirstBuild = false;
    }
  }

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

  List<Report> reportList = [
    Report(title: 'Report 1', issue: 'Issue 1'),
    Report(title: 'Report 2', issue: 'Issue 2'),
    Report(title: 'Report 3', issue: 'Issue 3'),
  ];

  late TextEditingController reportTitleController;
  late TextEditingController reportIssueController;

  @override
  void initState() {
    super.initState();

    reportTitleController = TextEditingController();
    reportIssueController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    didChangeDependencies();
    var stream = FirebaseFirestore.instance
        .collection('FormulaApp')
        .doc(widget.schoolDocId)
        .collection('majors')
        .doc(widget.majorDocId)
        .collection('courses')
        .doc(widget.courseDocId)
        .collection('formula');

    var reportStream = FirebaseFirestore.instance
        .collection('FormulaApp')
        .doc(widget.schoolDocId)
        .collection('majors')
        .doc(widget.majorDocId)
        .collection('courses')
        .doc(widget.courseDocId)
        .collection('formula')
        .doc(widget.docId)
        .collection('reports');

    runCount(stream);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              String title = '';
              String issue = '';
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        controller: reportTitleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: reportIssueController,
                        decoration: InputDecoration(
                          labelText: 'Issue',
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (reportIssueController.text.isEmpty ||
                              reportTitleController.text.isEmpty) {
                            const erMsg = SnackBar(
                              content: Text('one or more field is emplty!'),
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.all(20),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(erMsg);
                          } else {
                            await reportStream.add({
                              'title': reportTitleController.text,
                              'issue': reportIssueController.text,
                            });

                            reportIssueController.clear();
                            reportTitleController.clear();

                            const msg = SnackBar(
                              content: Text('Report Added'),
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.all(20),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(msg);

                            Navigator.pop(context);
                          }
                        },
                        child: Text('SUBMIT'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.report),
        tooltip: "Report a Suggestion/Issue?",
      ),
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
                BookmarkList().createState().RefreshBookMark();
                BookmarkList().createState().setState(() {});
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
      body: Stack(
        children: [
          SingleChildScrollView(
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
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)),
                  child: NetworkImageWidget(
                    imageUrl: widget.formulaurl,
                  ),
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
                        child: GestureDetector(
                          onTap: () async {
                            final Uri _url =
                                Uri.parse(widget.links[index].trim());
                            if (!await launchUrl(_url)) {
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
                              avatar: Icon(Icons.link_outlined),
                              elevation: 10,
                              label: Text(
                                extractDomain(widget.links[index].trim()),
                                style: TextStyle(color: Colors.blue),
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
                  spacing: 15.0,
                  children: (widget.tags.split(';'))
                      .map(
                        (tag) => Chip(
                          label: Text(tag.trim()),
                          elevation: 10,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: !show
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        show = true;
                      });
                    },
                    child: Icon(Icons.info_outline))
                : Center(
                    child: Card(
                      color: Colors.white,
                      elevation: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      show = false;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                  )),
                              const SizedBox(height: 15),
                              const Text(
                                "Information for Admins",
                                style: TextStyle(color: Colors.black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Chip(
                                avatar: Icon(Icons.remove_red_eye_outlined),
                                elevation: 10,
                                label: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('10 views'),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // if (reportList.length != 0)
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StreamBuilder(
                                          stream: reportStream.snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                              case ConnectionState.waiting:
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );

                                              default:
                                                if (snapshot.hasData) {
                                                  if (snapshot
                                                      .data!.docs.isEmpty) {
                                                    return const Center(
                                                      child: Text(
                                                          'no record found'),
                                                    );
                                                  } else {
                                                    return ListView(
                                                      children: snapshot
                                                          .data!.docs
                                                          .map((DocumentSnapshot
                                                              document) {
                                                        Map<String, dynamic>
                                                            data =
                                                            document.data()
                                                                as Map<String,
                                                                    dynamic>;
                                                        return ListTile(
                                                          title: Text(
                                                              data['title']),
                                                          subtitle: Text(
                                                              data['issue']),
                                                          trailing: IconButton(
                                                              onPressed: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      AlertDialog(
                                                                    title: const Text(
                                                                        'Delete'),
                                                                    content:
                                                                        const Text(
                                                                            'Are you sure you want to delete?'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () =>
                                                                                Navigator.of(context).pop(),
                                                                        child: const Text(
                                                                            'cancle'),
                                                                      ),
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          reportStream
                                                                              .doc(document.id)
                                                                              .delete();
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            'Delete'),
                                                                      )
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                              icon: Icon(Icons
                                                                  .delete)),
                                                        );
                                                      }).toList(),
                                                    );
                                                  }
                                                } else {
                                                  return const Center(
                                                    child:
                                                        Text('getting error'),
                                                  );
                                                }
                                            }
                                          });
                                      // ListView.builder(
                                      //   itemCount: reportList.length,
                                      //   itemBuilder:
                                      //       (BuildContext context, int index) {
                                      //     return ListTile(
                                      //       title:
                                      //           Text(reportList[index].title),
                                      //       subtitle:
                                      //           Text(reportList[index].issue),
                                      //       trailing: IconButton(
                                      //         icon: Icon(Icons.close),
                                      //         onPressed: () {
                                      //           // delete report
                                      //           setState(() {
                                      //             reportList.removeAt(index);
                                      //           });
                                      //           Navigator.pop(context);
                                      //         },
                                      //       ),
                                      //     );
                                      //   },
                                      // );
                                    },
                                  );
                                },
                                child: Chip(
                                  elevation: 10,
                                  avatar: const Icon(Icons.flag_outlined),
                                  label: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('${reportList.length} reports'),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ]),
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
