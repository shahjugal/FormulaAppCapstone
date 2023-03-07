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
        title: const Text('Add New Formula'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Name'),
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter New Name'),
            controller: nameController,
          ),
          const Text('Description'),
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter New Description'),
            controller: descriptionController,
          ),
          const Text('Formula'),
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter New Formula'),
            controller: formulaController,
          ),
          const Text('Application'),
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter New Application'),
            controller: applicationsController,
          ),
          const Text('Links'),
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter New Links'),
            controller: linksController,
          ),
          const Text('Related Courses'),
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter New Related Courses'),
            controller: relatedCoursesController,
          ),
          const Text('Tags'),
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter New Tags'),
            controller: tagsController,
          ),
          ElevatedButton(
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
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
