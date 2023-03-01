import 'package:flutter/material.dart';
import 'package:formula_app/StreamsUI.dart';
import 'subjects_ui.dart';

class SchoolUI extends StatefulWidget {
  @override
  State<SchoolUI> createState() => _SchoolUIState();
}

class _SchoolUIState extends State<SchoolUI> {
  final List<String> schoolCategories = [
    'Science',
    'Arts',
    'Business',
  ];

  Widget _buildCategoryCard(String category) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete School'),
              content: Text('Are you sure you want to delete $category?'),
              actions: <Widget>[
                TextButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('DELETE'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // TODO: delete school with category name
                    schoolCategories.remove(category);
                    setState(() {});
                  },
                ),
              ],
            );
          },
        );
      },
      onTap: () {
        // navigate to subjects UI when category is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StreamsUI(),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.grey[800],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 50.0,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 8.0),
            Text(
              category,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schools',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  String newSchoolName = '';
                  return AlertDialog(
                    title: Text('New School'),
                    content: TextField(
                      onChanged: (value) {
                        newSchoolName = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter school name',
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
                          // TODO: create new school with newSchoolName
                          schoolCategories.add(newSchoolName);
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
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // number of columns
          childAspectRatio: 1.2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: schoolCategories.asMap().entries.map((entry) {
            final int index = entry.key;
            final String category = entry.value;
            return GestureDetector(
              onLongPress: () {
                // show delete icon when grid is long pressed
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete School?'),
                      content:
                          Text('Are you sure you want to delete $category?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('CANCEL'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('DELETE'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            // TODO: delete school at index
                            schoolCategories.removeAt(index);
                            setState(() {});
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              onTap: () {
                // navigate to subjects UI when category is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StreamsUI(),
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
                        Icons.school,
                        size: 50.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        category,
                        maxLines: 2,
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
