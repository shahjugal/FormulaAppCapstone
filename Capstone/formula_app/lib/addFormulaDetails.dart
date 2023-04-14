import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  late TextEditingController applicationsController;
  late TextEditingController linksController;
  late TextEditingController tagsController;
  late TextEditingController physicalSignificance;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    applicationsController = TextEditingController();
    linksController = TextEditingController();
    tagsController = TextEditingController();
    physicalSignificance = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    // formulaController.dispose();
    applicationsController.dispose();
    linksController.dispose();
    tagsController.dispose();
    physicalSignificance.dispose();
    super.dispose();
  }

  String? formulaImageUrl;
  File? formulaImageFile;

  String? parametersImageUrl;
  File? parameterImageFile;

  Future formulaPickImage() async {
    try {
      final formulaImageFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (formulaImageFile == null) return;
      final String imgDevicePath = formulaImageFile.path;
      final String imgID =
          "${nameController.text} " + " ${imgDevicePath.replaceAll('/', '')}";
      Reference imgRef =
          FirebaseStorage.instance.ref().child('formula test').child(imgID);
      await imgRef.putFile(File(imgDevicePath));
      formulaImageUrl = await imgRef.getDownloadURL();
      // imgURL = await imgRef.getDownloadURL();
      final formulaimageTemporary = File(imgDevicePath);
      setState(() {
        this.formulaImageFile = formulaimageTemporary;

        print("=== for url mage ====${formulaImageUrl}");
        // print("=== url mage ====${formulaImageFile}");
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future parametersPickImage() async {
    try {
      final parameterImageFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (parameterImageFile == null) return;
      final String imgDevicePath = parameterImageFile.path;
      final String imgID =
          "${nameController.text} " + " ${imgDevicePath.replaceAll('/', '')}";
      Reference imgRef =
          FirebaseStorage.instance.ref().child('parameters test').child(imgID);
      await imgRef.putFile(File(imgDevicePath));
      parametersImageUrl = await imgRef.getDownloadURL();
      // imgURL = await imgRef.getDownloadURL();
      final parametersimageTemporary = File(imgDevicePath);
      setState(() {
        this.parameterImageFile = parametersimageTemporary;

        print("=== para url mage ====${parametersImageUrl}");
        // print("=== url mage ====${parameterImageFile}");
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
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
                  hintText: 'Enter Name',
                  border: OutlineInputBorder(),
                ),
                controller: nameController,
              ),
              const SizedBox(height: 24),
              const Text(
                'Formula / Equation',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => formulaPickImage(),
                child: const Text('Add formula image'),
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1)),
                child: formulaImageFile != null
                    ? ClipRRect(
                        child: Image.file(
                          formulaImageFile!,
                          fit: BoxFit.cover,
                        ), //Text("No image selected"),
                      )
                    : const Center(
                        child: Text('No image added'),
                      ),
              ),

              const SizedBox(height: 24),
              const Text(
                'Formula Parameters',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => parametersPickImage(),
                child: const Text('Add parameters image'),
              ),
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1)),
                child: parameterImageFile != null
                    ? ClipRRect(
                        child: Image.file(
                          parameterImageFile!,
                          fit: BoxFit.fill,
                        ), //Text("No image selected"),
                      )
                    : const Center(
                        child: Text('No image added'),
                      ),
              ),

              const SizedBox(height: 24),
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
                'Applications',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter  Applications ; seperated',
                  border: OutlineInputBorder(),
                ),
                controller: applicationsController,
              ),
              const SizedBox(height: 16),
              const Text(
                'Physical Significance',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter  Physical Significance ; seperated',
                  border: OutlineInputBorder(),
                ),
                controller: physicalSignificance,
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
                  hintText: 'Enter  Links ; seperated',
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
                  hintText: 'Enter  Tags ; seperated',
                  border: OutlineInputBorder(),
                ),
                controller: tagsController,
              ),
              SizedBox(
                height: 16,
              ),

              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty ||
                        nameController.text == null ||
                        descriptionController.text.isEmpty ||
                        descriptionController.text == null ||
                        applicationsController.text.isEmpty ||
                        applicationsController.text == null ||
                        tagsController.text.isEmpty ||
                        tagsController.text == null ||
                        linksController.text.isEmpty ||
                        linksController.text == null ||
                        physicalSignificance.text.isEmpty ||
                        physicalSignificance.text == null ||
                        formulaImageUrl == null ||
                        parametersImageUrl == null) {
                      const erMsg = SnackBar(
                        content: Text('one or more field is emplty!'),
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.all(20),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(erMsg);
                    } else {
                      print(
                          " === for URL add function ==== ${formulaImageUrl}");
                      await stream.add({
                        'name': nameController.text,
                        'description': descriptionController.text,
                        'applications': applicationsController.text,
                        'tags': tagsController.text,
                        'links': linksController.text,
                        'physical': physicalSignificance.text,
                        'formulaurl': formulaImageUrl,
                        'parameterurl': parametersImageUrl,
                        // 'formula': formulaController.text,
                      });

                      tagsController.clear();
                      linksController.clear();
                      applicationsController.clear();
                      // formulaController.clear();
                      descriptionController.clear();
                      nameController.clear();
                      physicalSignificance.clear();
                      setState(() {
                        parameterImageFile = null;
                        formulaImageFile = null;
                      });
                      const msg = SnackBar(
                        content: Text('Formula Added'),
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.all(20),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(msg);
                    }
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
