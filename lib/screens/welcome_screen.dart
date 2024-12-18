// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:chat_room/components/round_button.dart';
import 'package:chat_room/main.dart';
import 'package:chat_room/screens/chat_screen.dart';
import 'package:chat_room/screens/login_screen.dart';
import 'package:chat_room/screens/registration_screen.dart';
import 'package:chat_room/screens/rooms_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = "WelcomeScreen";
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  alreadySignedIn() async {
    String? userID = await Uauth.currentUser?.uid;
    if (await userID != null) {
      Navigator.pushNamed(context, RoomsScreen.id);
      print('Navigation Done');
    }
  }

  @override
  Widget build(BuildContext context) {
    // alreadySignedIn();
    return Scaffold(
      body: Container(
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Image.asset('images/Logo.png'),
                    width: 300,
                    height: 300,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MaterialButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        //Navigate (Push) to Login Screen
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text("Login"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: roundButton(
                      textColor: Colors.white,
                      function: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      buttontext: "Register",
                      color: Colors.orange,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
