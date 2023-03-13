import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formula_app/StreamsUI.dart';

class SchoolUI extends StatefulWidget {
  @override
  State<SchoolUI> createState() => _SchoolUIState();
}

class _SchoolUIState extends State<SchoolUI> {
  CollectionReference schoolStream =
      FirebaseFirestore.instance.collection('FormulaApp');

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
    Future<String?> openDialog() => showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('School Name'),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'Enter New School Name'),
              controller: controller,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(controller.text);
                  controller.clear();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schools',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () async {
              final newSchoolName = await openDialog();
              if (newSchoolName == null || newSchoolName.isEmpty) return;
              await schoolStream.add({'name': newSchoolName}).then(
                  (value) => print('school added'));
            },
          ),
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: schoolStream.snapshots(),
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
                                builder: (context) => StreamsUI(
                                  schoolDocId: document.id,
                                  schoolName: data['name'],
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
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('data'),
                                            content: Text(
                                                'Are you sure you want to delete?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text('cancle'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  schoolStream
                                                      .doc(document.id)
                                                      .delete();
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
                                      maxLines: 1,
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
                          // Card(
                          //   elevation: 4.0,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0),
                          //   ),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Expanded(
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(16.0),
                          //           child: Column(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.center,
                          //             children: [
                          //               Icon(
                          //                 Icons.school,
                          //                 size: 50.0,
                          //                 color: Theme.of(context).primaryColor,
                          //               ),
                          //               const SizedBox(height: 16.0),
                          //               Text(
                          //                 data['name'],
                          //                 overflow: TextOverflow.ellipsis,
                          //                 maxLines: 2,
                          //                 style: const TextStyle(
                          //                   fontSize: 16.0,
                          //                   fontWeight: FontWeight.bold,
                          //                   color: Colors.black,
                          //                   letterSpacing: 1.2,
                          //                 ),
                          //                 textAlign: TextAlign.center,
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //       Column(
                          //         children: [
                          //           IconButton(
                          //             icon: Icon(Icons.delete),
                          //             onPressed: () {
                          //               // Delete logic here
                          //             },
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
