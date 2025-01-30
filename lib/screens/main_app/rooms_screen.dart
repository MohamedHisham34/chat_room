// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations

import 'package:chat_room/widgets/round_button.dart';
import 'package:chat_room/main.dart';
import 'package:chat_room/screens/main_app/create_room_screen.dart';
import 'package:chat_room/screens/main_app/join_room_screen.dart';
import 'package:chat_room/screens/main_app/welcome_screen.dart';
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
            roundButton(
                buttontext: "Sign Out",
                color: Colors.black,
                function: () {
                  print("Done");
                  uAuth.signOut();
                  Navigator.pushNamed(context, WelcomeScreen.id);
                },
                textColor: Colors.white),
            Container(
              width: double.infinity,
              height: 250,
              child: Image.asset('images/person.png'),
            )
          ],
        ),
      ),
    );
  }
}
