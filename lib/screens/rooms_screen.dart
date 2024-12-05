// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_room/screens/create_room_screen.dart';
import 'package:chat_room/screens/join_room_screen.dart';
import 'package:flutter/material.dart';

class RoomsScreen extends StatelessWidget {
  // screen route id
  static final String id = "RoomsScreen";
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(context, CreateRoomScreen.id);
            },
            child: Text("Create Room"),
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.pushNamed(context, JoinRoomScreen.id);
            },
            child: Text("Join Room"),
          )
        ],
      )),
    );
  }
}
