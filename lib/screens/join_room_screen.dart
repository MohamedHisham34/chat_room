// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chat_room/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
String? roomNumber;
User? loggedInUser;

class JoinRoomScreen extends StatefulWidget {
  static final String id = "JoinRoomScreen";

  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  @override
  void initState() {
    getCurrentUser();
    super.initState();
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

  // This Method Used For Checking The Room Number

  void checkRoomNumber() async {
    // DocumentReference in the Database
    DocumentReference roomDocRef =
        FirebaseFirestore.instance.collection("Rooms").doc(roomNumber);
    //Geting all the Data in "Rooms" Collection
    DocumentSnapshot documentSnapshot = await roomDocRef.get();

    //Checking If The Document is Empty
    //That Means There Is No Room Exists with This Number
    try {
      if (!documentSnapshot.exists) {
        print('Wrong Room Number');
      }
      //Checking If The Document is Not Empty
      //That Means Room Number Exists
      if (documentSnapshot.exists) {
        bool? isCom = documentSnapshot.get("isCompleted");
        //Check If Room Is Full
        if (isCom == false) {
          db.collection("Rooms").doc(roomNumber).set({"isCompleted": true});
          print('Joined Room Succesfully');
          //Navigate to the Chat Screen
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ChatScreenTest(
                  userId: "${loggedInUser?.uid}", roomNumber: "${roomNumber}");
            },
          ));
        } else {
          print('Room Full');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Room'),
      ),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Room Number",
                hintStyle: TextStyle(color: Colors.grey)),
            onChanged: (value) {
              roomNumber = value;
            },
          ),
          MaterialButton(
            onPressed: () {
              checkRoomNumber();
            },
            color: Colors.red,
            child: Text(
              "Join",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
