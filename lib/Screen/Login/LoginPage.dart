import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_notebook_project/Navbar.dart';
import 'package:my_notebook_project/Screen/SignUp/signUpPage.dart';
import 'package:my_notebook_project/services/auth_services.dart';

class LoginPage extends StatelessWidget {
  final AuthServices _auth = AuthServices();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 110.0),
              child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 250.0,
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText('Your MemoMate is Ready. Sign In to Continue.', speed: Duration(milliseconds: 200)),
                            ],
                            isRepeatingAnimation: false,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                        child: TextField(
                          controller: _emailController,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white60,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black87),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      //SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(top:16,left: 16.0, right: 16, bottom: 16),
                        child: TextField(

                          controller: _passController,
                          style: TextStyle(color: Colors.black87),
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white60,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white60),

                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),

                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(

                        width: 350,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white70
                          ),
                          onPressed: () async {
                            User? user = await _auth.signInWithEmailAndPassword(
                              _emailController.text,
                              _passController.text,
                            );

                            if (user != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => NavbarPage()),
                              );
                            }
                          },
                          child: Text(

                            'Log In',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'New to MemoMate? ',
                        style: TextStyle(color: Colors.grey[800], fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                        },
                        child: Text("Sign Up Today!", style: TextStyle(color: Colors.grey[800], fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }
}
