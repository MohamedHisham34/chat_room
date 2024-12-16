// ignore_for_file: prefer_const_constructors

import 'package:chat_room/components/message_bubble.dart';
import 'package:chat_room/screens/create_room_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Firebase Firestore Services
final db = FirebaseFirestore.instance;

//Firebase Authentication Services
final auth = FirebaseAuth.instance;

// This ("loggenInUser") Is Future Value Of Current User
User? loggedInUser;

class ChatScreenTest extends StatefulWidget {
  const ChatScreenTest(
      {super.key, required this.userId, required this.roomNumber});

  final String userId;
  final String roomNumber;
  @override
  State<ChatScreenTest> createState() => _ChatScreenTestState();
}

String? messageContent;

// Execute getCurrentUser At The Start of Screen
class _ChatScreenTestState extends State<ChatScreenTest> {
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

// Getting Current User And Assign it to loggedInUser
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

//Messages Stream
  final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection('Rooms')
      .doc(roomNumber)
      .collection("Messages")
      .orderBy('timestamp')
      .snapshots();
  final Stream<DocumentSnapshot<Map<String, dynamic>>> roomMembers =
      FirebaseFirestore.instance
          .collection("Rooms")
          .doc(roomNumber)
          .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: roomMembers,
              builder: (context, snapshot) {
                return Text("${snapshot.data?['isCompleted']}");
              },
            ),
          ),
          //Room Number
          Text(widget.roomNumber),
          Expanded(
            child: StreamBuilder(
              stream: messageStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error Getting documents");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    // Checking If the Message Send By The Current User
                    if (snapshot.data?.docs[index]['sender'] ==
                        auth.currentUser?.email) {
                      //Viewing The Message with Right alignment
                      // (If the Current User Send This Message)

                      return message_bubble(
                          snapshotSender: snapshot.data?.docs[index]['sender'],
                          snapshotMessageContent: snapshot.data?.docs[index]
                              ['messageContent'],
                          isSender: true,
                          color: Colors.blue);
                    }
                    //Viewing The Message with Left alignment
                    // (If Not The Current User Send This Message)
                    return message_bubble(
                        snapshotSender: snapshot.data?.docs[index]['sender'],
                        snapshotMessageContent: snapshot.data?.docs[index]
                            ['messageContent'],
                        isSender: false,
                        color: Colors.grey);
                  },
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.lightBlue),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      messageContent = value;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //Adding User Messages to FireBase DataBase
                    FirebaseFirestore.instance
                        .collection("Rooms")
                        .doc("${widget.roomNumber}")
                        .collection("Messages")
                        .add({
                      "messageContent": messageContent,
                      "sender": "${loggedInUser?.email}",
                      "timestamp": FieldValue.serverTimestamp()
                    });
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
