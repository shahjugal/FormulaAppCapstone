import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddFormulaDetails extends StatefulWidget {
  final String schoolDocId;
  final String majorDocId;
  final String courseDocId;
  final String courseName;
  const AddFormulaDetails({
    super.key,
    required this.courseDocId,
    required this.majorDocId,
    required this.schoolDocId,
    required this.courseName,
  });

  @override
  State<AddFormulaDetails> createState() => _AddFormulaDetailsState();
}

class _AddFormulaDetailsState extends State<AddFormulaDetails> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController formulaController;
  late TextEditingController applicationsController;
  late TextEditingController linksController;
  late TextEditingController relatedCoursesController;
  late TextEditingController tagsController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    formulaController = TextEditingController();
    applicationsController = TextEditingController();
    linksController = TextEditingController();
    relatedCoursesController = TextEditingController();
    tagsController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    formulaController.dispose();
    applicationsController.dispose();
    linksController.dispose();
    relatedCoursesController.dispose();
    tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Add Formula',
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Enter New Name',
                border: OutlineInputBorder(),
              ),
              controller: nameController,
            ),
            SizedBox(height: 16),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter New Description',
                border: OutlineInputBorder(),
              ),
              controller: descriptionController,
            ),
            SizedBox(height: 16),
            Text(
              'Formula',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter New Formula',
                border: OutlineInputBorder(),
              ),
              controller: formulaController,
            ),
            SizedBox(height: 16),
            Text(
              'Application',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter New Application',
                border: OutlineInputBorder(),
              ),
              controller: applicationsController,
            ),
            SizedBox(height: 16),
            Text(
              'Links',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter New Links',
                border: OutlineInputBorder(),
              ),
              controller: linksController,
            ),
            SizedBox(height: 16),
            Text(
              'Related Courses',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter New Related Courses',
                border: OutlineInputBorder(),
              ),
              controller: relatedCoursesController,
            ),
            SizedBox(height: 16),
            Text(
              'Tags',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter New Tags',
                border: OutlineInputBorder(),
              ),
              controller: tagsController,
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await stream.add({
                    'name': nameController.text,
                    'description': descriptionController.text,
                    'applications': applicationsController.text,
                    'tags': tagsController.text,
                    'relatedcourses': relatedCoursesController.text,
                    'links': linksController.text,
                    'formula': formulaController.text,
                  });

                  tagsController.clear();
                  relatedCoursesController.clear();
                  linksController.clear();
                  applicationsController.clear();
                  formulaController.clear();
                  descriptionController.clear();
                  nameController.clear();
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
