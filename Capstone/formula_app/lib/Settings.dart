import 'package:flutter/material.dart';

class SettingsUI extends StatefulWidget {
  const SettingsUI({super.key});

  @override
  State<SettingsUI> createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("No Updates Available at the momnent!"),
            SizedBox(height: 10),
            Text("Current Version " + "0.0.1(Alpha Stage)")
          ],
        ),
      ),
    );
  }
}
