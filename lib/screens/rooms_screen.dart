// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chat_room/components/round_button.dart';
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
      backgroundColor: Color.fromARGB(255, 27, 118, 188),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Image.asset('images/Logo-White.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      roundButton(
                          buttontext: "Create Room",
                          color: Colors.white,
                          textColor: Colors.black,
                          function: () {
                            Navigator.pushNamed(context, CreateRoomScreen.id);
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      roundButton(
                          buttontext: "Join Room",
                          color: Colors.orange,
                          textColor: Colors.white,
                          function: () {
                            Navigator.pushNamed(context, JoinRoomScreen.id);
                          })
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 300,
              child: Image.asset('images/person.png'),
            )
          ],
        ),
      ),
    );
  }
}
