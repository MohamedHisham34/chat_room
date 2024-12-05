// ignore_for_file: prefer_const_declarations, unnecessary_string_interpolations

import 'package:chat_room/screens/chat_screen.dart';
import 'package:chat_room/screens/chat_screen_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
String roomNumber = 333444.toString();
String? rName;
User? loggedInUser;

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
    getCurrentUser();
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

  void getCurrentUser() async {
    try {
      final user = await auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Text(roomNumber),
          TextField(
            onChanged: (value) {
              rName = value;
            },
            decoration: InputDecoration(
              hintText: "Room Name",
              hintStyle: TextStyle(
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ),
          MaterialButton(
            color: Colors.red,
            onPressed: () {
              db
                  .collection("Rooms")
                  .doc(roomNumber)
                  .set({"rName": rName, "isCompleted": false});

              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ChatScreenTest(
                    userId: "${loggedInUser?.uid}",
                    roomNumber: roomNumber,
                  );
                },
              ));
            },
            child: Text("Create Room"),
          ),
        ]),
      ),
    );
  }
}
