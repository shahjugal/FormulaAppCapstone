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
  late TextEditingController tagsController;
  late TextEditingController sample1;
  late TextEditingController sample3;
  late TextEditingController sample2;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    formulaController = TextEditingController();
    applicationsController = TextEditingController();
    linksController = TextEditingController();
    tagsController = TextEditingController();
    sample1 = TextEditingController();
    sample2 = TextEditingController();
    sample3 = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    formulaController.dispose();
    applicationsController.dispose();
    linksController.dispose();
    tagsController.dispose();
    sample1.dispose();
    sample2.dispose();
    sample3.dispose();
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Enter New Name',
                  border: OutlineInputBorder(),
                ),
                controller: nameController,
              ),
              const SizedBox(height: 16),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter New Description',
                  border: OutlineInputBorder(),
                ),
                controller: descriptionController,
              ),
              const SizedBox(height: 16),
              const Text(
                'Formula',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter New Formula',
                  border: OutlineInputBorder(),
                ),
                controller: formulaController,
              ),
              const SizedBox(height: 16),
              const Text(
                'Applications',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter New Applications space seperated',
                  border: OutlineInputBorder(),
                ),
                controller: applicationsController,
              ),
              const SizedBox(height: 16),
              const Text(
                'Links',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter New Links',
                  border: OutlineInputBorder(),
                ),
                controller: linksController,
              ),
              const SizedBox(height: 16),
              const Text(
                'Tags',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter New Tags',
                  border: OutlineInputBorder(),
                ),
                controller: tagsController,
              ),
              const SizedBox(height: 16),
              const Text(
                'Sample1',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter New sample1',
                  border: OutlineInputBorder(),
                ),
                controller: sample1,
              ),
              const SizedBox(height: 16),
              const Text(
                'sample2',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter New sample2',
                  border: OutlineInputBorder(),
                ),
                controller: sample2,
              ),
              const SizedBox(height: 16),
              const Text(
                'sample3',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter New sample3',
                  border: OutlineInputBorder(),
                ),
                controller: sample3,
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await stream.add({
                      'name': nameController.text,
                      'description': descriptionController.text,
                      'applications': applicationsController.text,
                      'tags': tagsController.text,
                      'links': linksController.text,
                      'formula': formulaController.text,
                    });

                    tagsController.clear();
                    linksController.clear();
                    applicationsController.clear();
                    formulaController.clear();
                    descriptionController.clear();
                    nameController.clear();
                    const msg = SnackBar(
                      content: Text('Formula Added'),
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.all(20),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(msg);
                  },
                  child: const Text('Submit'),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
