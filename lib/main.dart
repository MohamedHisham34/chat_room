// ignore_for_file: prefer_const_constructors

import 'package:chat_room/screens/login_screen.dart';
import 'package:chat_room/screens/registration_screen.dart';
import 'package:chat_room/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        //WelcomeScreen Route
        WelcomeScreen.id: (context) => WelcomeScreen(),

        //Login and Registration screen
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}
