// ignore_for_file: prefer_const_declarations, unnecessary_string_interpolations, prefer_const_constructors

import 'package:chat_room/widgets/round_button.dart';
import 'package:chat_room/constants/Colors.dart';
import 'package:chat_room/main.dart';
import 'package:chat_room/models/room_model.dart';
import 'package:chat_room/screens/main_app/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

String roomNumber = Random().nextInt(999999).toString();
String? rName;

class CreateRoomScreen extends StatefulWidget {
  static final String id = "CreateRoomScreen";
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  @override
  void initState() {
    checkRepeatedGenNumber();
    super.initState();
  }

  void checkRepeatedGenNumber() async {
    await db.collection("Rooms").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          if (roomNumber == docSnapshot.id) {
            print("Generated Number Been Used");
            roomNumber = Random().nextInt(999999).toString();
            setState(() {});
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PrimaryBlueColor,
        title: Text(
          "Create Room",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: PrimaryBlueColor,
      body: SafeArea(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            width: double.infinity,
            height: 250,
            child: Image.asset('images/Logo-White.png'),
          ),
          Text(
            "Room Number",
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 5),
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child: Center(
                  child: Text(
                roomNumber,
                style: TextStyle(fontSize: 35, letterSpacing: 10),
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                rName = value;
              },
              decoration: InputDecoration(
                hintText: "Room Name",
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: roundButton(
                buttontext: "Create Room",
                color: PrimaryOrangeColor,
                function: () {
                  //Room Information ADD To Firebase
                  RoomClass room =
                      RoomClass(roomName: rName, isCompleted: false);
                  db.collection("Rooms").doc(roomNumber).set(room.roomData());

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ChatScreen(
                        roomNumber: roomNumber,
                      );
                    },
                  ));
                  CircularProgressIndicator();
                },
                textColor: Colors.white),
          )
        ]),
      ),
    );
  }
}
