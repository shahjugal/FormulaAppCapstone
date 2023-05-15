import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SettingsUI extends StatefulWidget {
  const SettingsUI({super.key});

  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  bool _sortAscending = true;
  int _sortColumnIndex = 1;
  var reportNum;
  var parentid;

  final List<Map<String, dynamic>> _data = [
    {
      'name': 'energy eq',
      'views': 50,
      'reports': 2,
    },
    {
      'name': 'mass eqn',
      'views': 20,
      'reports': 1,
    },
    {
      'name': 'Mole law',
      'views': 100,
      'reports': 4,
    },
    {
      'name': 'Work Energy threom',
      'views': 30,
      'reports': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // var reportStream = FirebaseFirestore.instance
    //     .collectionGroup('formula')
    //     .orderBy('count', descending: true);
    // var reportStream;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Formula Analytics'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                const Text('Sort in (manner): '),
                DropdownButton<bool>(
                  value: _sortAscending,
                  onChanged: (value) {
                    setState(() {
                      _sortAscending = value!;
                      print("sort ========= ${_sortAscending}");
                      // reportStream = FirebaseFirestore.instance
                      //     .collectionGroup('formula')
                      //     .orderBy('count', descending: _sortAscending);
                    });
                  },
                  items: const [
                    DropdownMenuItem<bool>(
                      value: true,
                      child: Text('Ascending'),
                    ),
                    DropdownMenuItem<bool>(
                      value: false,
                      child: Text('Descending'),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(

                // stream: reportStream.snapshots(),
                stream: FirebaseFirestore.instance
                    .collectionGroup('formula')
                    .orderBy('count', descending: !_sortAscending)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No data found'));
                  }

                  final documents = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      final document = documents[index];
                      final number = document['count'];
                      final docId = document.id;

                      return ListTile(
                        title: Text("${document['name']}"),
                        subtitle: Text("Views: ${number}  "),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
