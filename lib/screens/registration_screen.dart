import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static final String id = "RegistrationScreen";
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Regitration Screen"),
      ),
    );
  }
}
