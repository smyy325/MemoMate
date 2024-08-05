import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notebook_project/Navbar.dart';
import 'package:my_notebook_project/services/auth_services.dart';

import '../Login/LoginPage.dart';
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthServices _auth = AuthServices();
  final TextEditingController _nameController = TextEditingController();
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
                image: AssetImage('assets/signup.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 250.0,
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText('Existing Member? Log In to Get Started!', speed: Duration(milliseconds: 200)),
                            ],
                            isRepeatingAnimation: false,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _nameController,
                        style: TextStyle(color: Colors.black),
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
                          labelText: "Full Name",
                          labelStyle: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
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
                      SizedBox(height: 16),
                      TextField(

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
                      SizedBox(height: 16),
                      SizedBox(
                        width: 350,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white70
                          ),
                          onPressed: () async {
                            User? user = await _auth.registerWithEmailAndPassword(
                              _nameController.text,
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

                            'Sign Up',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Access Your Account',
                        style: TextStyle(color: Colors.grey[800], fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: Text("Log In Now!", style: TextStyle(color: Colors.grey[800], fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
