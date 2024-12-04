// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
final genNumber = "333444";
String? rName;

class Cardtest extends StatelessWidget {
  static final id = "test";
  const Cardtest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Text(genNumber),
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
                  .doc(genNumber)
                  .set({"rName": rName, "isCompleted": false});

              db.collection("Rooms").doc(genNumber).collection("Messages").add(
                  {"sender": "ali@gmail.com", "messageContent": "Hello hello"});
            },
            child: Text("Create Room"),
          ),
        ]),
      ),
    );
  }
}
