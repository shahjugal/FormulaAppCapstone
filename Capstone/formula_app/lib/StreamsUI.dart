import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'subjects_ui.dart';

class StreamsUI extends StatefulWidget {
  final String schoolName;
  final String schoolDocId;

  const StreamsUI({
    super.key,
    required this.schoolDocId,
    required this.schoolName,
  });
  @override
  _StreamsUIState createState() => _StreamsUIState();
}

class _StreamsUIState extends State<StreamsUI> {
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
    var majorStream = FirebaseFirestore.instance
        .collection('FormulaApp')
        .doc(widget.schoolDocId)
        .collection('majors');

    Future<String?> openDialog() => showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Major Name'),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'Enter New Major Name'),
              controller: controller,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(controller.text);
                  controller.clear();
                },
                child: Text('Submit'),
              )
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.schoolName,
          style: TextStyle(
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
            onPressed: () async {
              final newMajorName = await openDialog();
              if (newMajorName == null || newMajorName.isEmpty) return;
              await majorStream.add({'name': newMajorName}).then(
                  (value) => print('major added'));
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: majorStream.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: Text('please wait'),
              );
            default:
              if (snapshot.hasData) {
                print(snapshot.data!.docs.length);
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('no record found'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.count(
                      crossAxisCount: 2, // number of columns
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return GestureDetector(
                          onTap: () {
                            // navigate to subjects UI when category is tapped

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubjectsUI(
                                  schoolDocId: widget.schoolDocId,
                                  majorDocId: document.id,
                                  majorName: data['name'],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        // handle edit icon tap
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        // handle delete icon tap
                                      },
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Center(
                                    child: Icon(
                                      Icons.school,
                                      size: 50.0,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data['name'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        letterSpacing: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
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
