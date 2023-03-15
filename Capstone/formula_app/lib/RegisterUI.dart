// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:formula_app/LoginUI.dart';
import '../Widgets/f_textfield.dart';

class RegisterUI extends StatelessWidget {
  const RegisterUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 177, 212, 224),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 20,
                ),
                // ignore: prefer_const_constructors
                Text(
                  "Get Started",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 12, 45, 72),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 10,
                ),
                // ignore: prefer_const_constructors
                Text(
                  "Create a account for this service.",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 12, 45, 72),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Icon(
                  Icons.person_add,
                  size: 175,
                  color: Color.fromARGB(255, 20, 93, 160),
                ),
                const SizedBox(
                  height: 17,
                ),
                fTextBox("University Email", false),
                SizedBox(
                  height: 10,
                ),
                fTextBox("Password", true),
                SizedBox(height: 10),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 20, 93, 160),
                        borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(10)),
                      ),
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginUI()),
                          );
                        },
                        child: Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 12, 45, 72),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
