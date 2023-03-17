import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:formula_app/addFormulaDetails.dart';
import 'package:formula_app/formuladetailsscreen.dart';

class FormulaListUI extends StatefulWidget {
  final String schoolDocId;
  final String majorDocId;
  final String courseDocId;
  final String courseName;

  FormulaListUI({
    super.key,
    required this.courseDocId,
    required this.majorDocId,
    required this.schoolDocId,
    required this.courseName,
  });

  @override
  _FormulaListUIState createState() => _FormulaListUIState();
}

class _FormulaListUIState extends State<FormulaListUI> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _showDeleteAlert() {
      return AlertDialog(
        title: const Text('Delete'),
        content: Container(
          child: const Text('data'),
        ),
        actions: const [
          TextButton(
            onPressed: null,
            child: Text('data'),
          ),
        ],
      );
    }

    var stream = FirebaseFirestore.instance
        .collection('FormulaApp')
        .doc(widget.schoolDocId)
        .collection('majors')
        .doc(widget.majorDocId)
        .collection('courses')
        .doc(widget.courseDocId)
        .collection('formula');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.courseName,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddFormulaDetails(
                    courseDocId: widget.courseDocId,
                    courseName: widget.courseName,
                    majorDocId: widget.majorDocId,
                    schoolDocId: widget.schoolDocId,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: stream.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text('please wait'),
              );
            default:
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('no record found'),
                  );
                } else {
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Card(
                        child: ListTile(
                          title: Text(data['name']),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('data'),
                                      content: const Text(
                                          'Are you sure you want to delete?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('cancle'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            stream.doc(document.id).delete();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Delete'),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            print("formula === ${data['links']}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormulaDetailsScreen(
                                  applications: (data['applications']),
                                  description: data['description'],
                                  formula: data['formula'],
                                  name: data['name'],
                                  tags: data['tags'],
                                  links: data['links'].split(';'),
                                  relatedCourses: data['relatedcourses'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                }
              } else {
                return const Center(
                  child: Text('getting error'),
                );
              }
          }
        },
      ),
    );
  }
}
