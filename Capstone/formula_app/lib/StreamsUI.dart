import 'package:flutter/material.dart';
import 'subjects_ui.dart';

class StreamsUI extends StatefulWidget {
  @override
  _StreamsUIState createState() => _StreamsUIState();
}

class _StreamsUIState extends State<StreamsUI> {
  List<String> engineeringStreams = [
    'Civil Engineering',
    'Mechanical Engineering',
    'Electrical Engineering',
    'Electronics and Communication Engineering',
    'Computer Science and Engineering',
    'Aerospace Engineering',
    'Chemical Engineering',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Engineering Streams',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  String newStreamName = '';
                  return AlertDialog(
                    title: Text('New Stream'),
                    content: TextField(
                      onChanged: (value) {
                        newStreamName = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter stream name',
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('CREATE'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // TODO: create new stream with newStreamName
                          engineeringStreams.add(newStreamName);
                          setState(() {});
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // number of columns
          childAspectRatio: 1.2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: engineeringStreams.map((stream) {
            return GestureDetector(
              onTap: () {
                // navigate to subjects UI when stream is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectsUI(),
                  ),
                );
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.grey[800],
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.engineering,
                        size: 50.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        stream,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
