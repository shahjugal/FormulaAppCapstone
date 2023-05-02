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


  @override
  Widget build(BuildContext context) {
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
                            decoration: InputDecoration(
                              labelText: 'Title',
                            ),
                            onChanged: (value) {
                              title = value;
                            },
                          ),
                          SizedBox(height: 16.0),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Issue',
                            ),
                            onChanged: (value) {
                              issue = value;
                            },
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              if (title.isNotEmpty && issue.isNotEmpty) {
                                setState(() {
                                  reportList.add(Report(title: title, issue: issue));
                                });
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
            child: Icon(Icons.report
            ),
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
        children: [SingleChildScrollView(
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
                          final Uri _url = Uri.parse(widget.links[index].trim());
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
                    .map((tag) => Chip(label: Text(tag.trim()), elevation: 10,), )
                    .toList(),
              ),
              
              
          
            ],
          ),
        ),
        Positioned(child: Center(
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withAlpha(100),backgroundBlendMode: BlendMode.overlay),
              child: Column(mainAxisAlignment: MainAxisAlignment.start ,children: [
                Text("Information for Admins", style: TextStyle(color: Colors.white),),
                SizedBox(height: 10,),
                    Chip(
                            avatar: const Icon(Icons.remove_red_eye_outlined),
                    elevation: 10,
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('10 views'),
                    ),
                          ),
                          SizedBox(height: 10,),
              
              GestureDetector(
              onTap: () {
                if(reportList.length!=0)
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
              return ListView.builder(
                itemCount: reportList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(reportList[index].title),
                    subtitle: Text(reportList[index].issue),
                    trailing: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        // delete report
                        setState(() {
                          reportList.removeAt(index);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
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
                    )
                    ,
                  ]),
            ),
          ),
        ), top: 10,right: 10,)
        ],
        
      ),
    );
  }
}
