import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:formula_app/formuladetailsscreen.dart';

class SearchTags extends StatefulWidget {
  const SearchTags({super.key});
  @override
  State<SearchTags> createState() => _SearchTagsState();
}

class _SearchTagsState extends State<SearchTags> {
  String? enteredText;

  @override
  Widget build(BuildContext context) {
    var stream = FirebaseFirestore.instance.collectionGroup('formula');

    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            child: Material(
              elevation: 5,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    enteredText = value;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove the border from text field
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: stream.snapshots().asBroadcastStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return enteredText == null || enteredText == ""
                          ? Center(
                              child: Text('Enter something to search for...'),
                            )
                          : ListView(
                              children: [
                                ...snapshot.data!.docs
                                    .where((QueryDocumentSnapshot<Object?>
                                            element) =>
                                        element['tags']
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                enteredText!.toLowerCase()))
                                    .map(
                                  (QueryDocumentSnapshot<Object?> data) {
                                    final String searchTags = data.get('tags');
                                    final String searchName = data.get('name');
                                    final String searchPhysical =
                                        data.get('physical');
                                    final String searchFormulaurl =
                                        data.get('formulaurl');

                                    final String searchParameterurl =
                                        data.get('parameterurl');
                                    // final String searchFomula =
                                    final String searchDescription =
                                        data.get('description');
                                    final String searchApplications =
                                        data.get('applications');
                                    final String searchLinks =
                                        data.get('links');
                                    return Container(
                                      margin: EdgeInsets.all(8),
                                      child: Material(
                                        elevation: 5,
                                        child: ListTile(
                                          title: Text(
                                            searchName,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Wrap(
                                            spacing: 8,
                                            children: searchTags
                                                .split(';')
                                                .map(
                                                  (e) => Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Chip(
                                                      label: Text(
                                                        e.trim(),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      elevation: 2,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FormulaDetailsScreen(
                                                  name: searchName,
                                                  formulaurl: searchFormulaurl,
                                                  parameterurl:
                                                      searchParameterurl,
                                                  physical: searchPhysical,
                                                  description:
                                                      searchDescription,
                                                  // formula: searchFomula,
                                                  applications:
                                                      searchApplications,
                                                  links: searchLinks.split(';'),
                                                  // relatedCourses:
                                                  //     searchRelatedcourses,
                                                  tags: searchTags,
                                                ),
                                              ),
                                            );
                                          },
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          tileColor: Colors.white,
                                          minVerticalPadding: 12,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              Center(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("End of search results."),
                              )),
                              SizedBox(height: 20,),
                              ],
                            );
                    }
                  })),
        ],
      ),
    );
  }
}
