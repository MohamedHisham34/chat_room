// ignore_for_file: prefer_const_constructors

import 'package:chat_room/screens/login_screen.dart';
import 'package:chat_room/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = "WelcomeScreen";
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    color: Colors.red,
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Chat Room",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: MaterialButton(
                  onPressed: () {
                    //Navigate (Push) to Login Screen
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("Login"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: MaterialButton(
                  //Navigate (Push) to Registration Screen
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text("Register"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
