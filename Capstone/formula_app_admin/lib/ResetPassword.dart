import 'package:flutter/material.dart';
import 'package:formula_app/RegisterUI.dart';
import '../Widgets/f_textfield.dart';
import 'LoginUI.dart';

class ResetPasswordUI extends StatelessWidget {
  const ResetPasswordUI({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 177, 212, 224),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Reset Password",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 12, 45, 72)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Please enter your email address to reset your password.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Color.fromARGB(255, 12, 45, 72),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Icon(
                  Icons.email,
                  size: 175,
                  color: Color.fromARGB(255, 20, 93, 160),
                ),
                SizedBox(
                  height: 17,
                ),
                fTextBox("Email Address", false),
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
                          "Send Reset Link",
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
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterUI()),
                          );
                        },
                        child: Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 12, 45, 72),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginUI()),
                          );
                        },
                        child: Text(
                          "Remember Login Credentials?",
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
