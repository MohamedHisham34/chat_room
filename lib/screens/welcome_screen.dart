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
      body: Center(
        child: Text("WelcomeScreen"),
      ),
    );
  }
}
