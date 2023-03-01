import 'package:flutter/material.dart';
import 'package:formula_app/formuladetailsscreen.dart';

class FormulaListUI extends StatefulWidget {
  @override
  _FormulaListUIState createState() => _FormulaListUIState();
}

class _FormulaListUIState extends State<FormulaListUI> {
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
          'Formulas',
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
                  String newFormulaName = '';
                  return AlertDialog(
                    title: Text('New Formula'),
                    content: TextField(
                      onChanged: (value) {
                        newFormulaName = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter formula name',
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
                          formulas.add(newFormulaName);
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
      body: ListView.builder(
        itemCount: formulas.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Card(
              elevation: 4.0,
              color: Colors.grey[800],
              child: ListTile(
                title: Text(
                  formulas[index],
                  style: TextStyle(
                    color: Colors.white,
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
    );
  }
}
