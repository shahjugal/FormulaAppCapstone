import 'package:flutter/material.dart';

import 'formuladetailsscreen.dart';

class SearchResultsUI extends StatefulWidget {
  final String title;

  const SearchResultsUI({Key? key, required this.title}) : super(key: key);

  @override
  State<SearchResultsUI> createState() => _SearchResultsUIState();
}

class _SearchResultsUIState extends State<SearchResultsUI> {
  List<String> formulas = [
    'First law of thermodynamics',
    'Second law of thermodynamics',
    'Carnot cycle',
    'Entropy',
    'Enthalpy',
    'Heat capacity',
    'Ideal gas law',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search results for " + widget.title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.5),
        child: ListView.builder(
          itemCount: formulas.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Card(
                elevation: 4.0,
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    formulas[index],
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormulaDetailsScreen(
                          name: 'Ideal Gas Law',
                          description:
                              'The ideal gas law relates the pressure, volume, temperature, and number of particles of an ideal gas in a closed system.',
                          latexString: 'PV = nRT',
                          applications: [
                            'Calculating the pressure, volume, or temperature of a gas in a closed system',
                            'Determining the number of moles of gas in a system',
                            'Estimating the behavior of real gases under different conditions',
                          ],
                          links: [
                            'https://en.wikipedia.org/wiki/Ideal_gas_law',
                            'https://www.khanacademy.org/science/chemistry/gases-and-kinetic-molecular-theory/ideal-gas-laws/v/what-is-the-ideal-gas-law',
                            'https://www.chem.purdue.edu/gchelp/howtosolveit/Gases/IdealGasLaw.htm',
                          ],
                          relatedCourses: [
                            'Thermodynamics',
                            'Physical Chemistry',
                            'Chemical Engineering',
                          ],
                          tags: [
                            'thermodynamics',
                            'gas laws',
                            'chemistry',
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ), //Center(
      //   child: Text(
      //     'No search results found.',
      //     style: TextStyle(fontSize: 24.0),
      //   ),
      // ),
    );
  }
}
