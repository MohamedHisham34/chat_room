// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chat_room/widgets/round_button.dart';
import 'package:chat_room/constants/Colors.dart';
import 'package:chat_room/screens/main_app/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

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
          print('Joined Room Successfully');
          //Navigate to the Chat Screen
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ChatScreen(roomNumber: "${roomNumber}");
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
      backgroundColor: PrimaryBlueColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PrimaryWhiteColor,
        title: Text(
          "Join Room",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            height: 250,
            child: Image.asset('images/Logo-White.png'),
          ),
          Text(
            "Enter Room Number",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(
            height: 15,
            width: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Pinput(
              defaultPinTheme: PinTheme(
                height: 45,
                decoration: BoxDecoration(
                  color: PrimaryGreyColor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              length: 6,
              onChanged: (value) {
                roomNumber = value;
              },
            ),
          ),

          SizedBox(
            height: 15,
            width: 30,
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: VerificationCode(
          //     onCompleted: (value) {},
          //     onEditing: (value) {
          //       checkRoomNumber();
          //     },
          //     length: 6,
          //     keyboardType: TextInputType.number,
          //     fillColor: PrimaryGreyColor,
          //     cursorColor: Colors.black,
          //     fullBorder: true,
          //     textStyle: TextStyle(color: Colors.black),
          //   ),
          // ),
          SizedBox(
            height: 20,
            width: 30,
          ),
          // TextField(
          //   keyboardType: TextInputType.number,
          //   decoration: InputDecoration(
          //       hintText: "Room Number",
          //       hintStyle: TextStyle(color: Colors.grey)),
          //   onChanged: (value) {
          //     roomNumber = value;
          //   },
          // ),
          Text(
            "Enter The 6 digits Unique Number Of The Room",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: roundButton(
                height: 50,
                buttontext: "Join Room",
                color: PrimaryOrangeColor,
                function: () {
                  checkRoomNumber();
                },
                textColor: Colors.white),
          ),
        ],
      ),
    );
  }
}
