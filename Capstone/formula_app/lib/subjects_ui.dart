import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'FormulaListUI.dart';

class SubjectsUI extends StatefulWidget {
  final String majorName;
  final String majorDocId;
  final String schoolDocId;

  const SubjectsUI(
      {super.key,
      required this.majorDocId,
      required this.majorName,
      required this.schoolDocId});
  @override
  _SubjectsUIState createState() => _SubjectsUIState();
}

class _SubjectsUIState extends State<SubjectsUI> {
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
    var stream = FirebaseFirestore.instance
        .collection('FormulaApp')
        .doc(widget.schoolDocId)
        .collection('majors')
        .doc(widget.majorDocId)
        .collection('courses');

    Future<String?> openDialog() => showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Course Name'),
            content: TextField(
              autofocus: true,
              decoration:
                  const InputDecoration(hintText: 'Enter New Course Name'),
              controller: controller,
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.majorName,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: stream.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasData) {
                // print(snapshot.data!.docs.length);
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

                          //subtitle: Text(data['definition']),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormulaListUI(
                                  schoolDocId: widget.schoolDocId,
                                  majorDocId: widget.majorDocId,
                                  courseDocId: document.id,
                                  courseName: data['name'],
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






    // ListView.builder(
    //   itemCount: subjects.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Padding(
    //       padding: const EdgeInsets.only(left: 10, right: 10),
    //       child: Card(
    //         elevation: 4.0,
    //         color: Colors.white,
    //         child: ListTile(
    //           title: Text(
    //             subjects[index],
    //             style: TextStyle(
    //               color: Colors.black,
    //             ),
    //           ),
    //           onTap: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => FormulaListUI(),
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //     );
    //   },
    // ),
  
