import 'package:flutter/material.dart';

class SettingsUI extends StatefulWidget {
  const SettingsUI({super.key});

  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  bool _sortAscending = false;
  int _sortColumnIndex = 2;

  final List<Map<String, dynamic>> _data = [    {      'name': 'energy eq',      'views': 50,      'reports': 2,    },    {      'name': 'mass eqn',      'views': 20,      'reports': 1,    },    {      'name': 'Mole law',      'views': 100,      'reports': 4,    },    {      'name': 'Work Energy threom',      'views': 30,      'reports': 3,    },  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
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
                    // Joileje tari rite. firebase me je query apvani hoy e. 
                    // Downloading all formula and sorting on local device is not feasible.
                    setState(() {
                      _sortAscending = value!;
                    });
                  },
                   items:  [
                     DropdownMenuItem<bool>(
                      value: true,
                      child:  Text('Ascending'),
                    ),
                     DropdownMenuItem<bool>(
                      value: false,
                      child:  Text('Descending'),
                    ),
                  ],
                ),
                const Spacer(),
                const Text('Sort by: '),
                 DropdownButton<int>(
                  value: _sortColumnIndex,
                  onChanged: (value) {
                    // Joileje tari rite. firebase me je query apvani hoy e. 
                    // Downloading all formula and sorting on local device is not feasible.
                    setState(() {
                      _sortColumnIndex = value!;
                    });
                  },
                   items:  [
                     DropdownMenuItem<int>(
                      value: 1,
                      child:  Text('Views'),
                    ),
                     DropdownMenuItem<int>(
                      value: 2,
                      child:  Text('Reports'),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child:  Text('Name'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final item = _data[index];
                return ListTile(
                  onTap: (){
                    // Aiya formula page par push karvanu hoyto joileje na jarur hoyto khali rekjhe. ur choice.
                  },
                  title: Text(item['name']),
                  subtitle: Text('Views: ${item['views']} Reports: ${item['reports']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
