// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class RoomsScreen extends StatelessWidget {
  static final String id = "RoomsScreen";
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          MaterialButton(
            onPressed: () {},
            child: Text("Create Room"),
          ),
          MaterialButton(
            onPressed: () {},
            child: Text("Join Room"),
          )
        ],
      )),
    );
  }
}
