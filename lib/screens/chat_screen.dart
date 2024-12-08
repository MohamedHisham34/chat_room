// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, await_only_futures, curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:ffi';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_room/components/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//Firebase Firestore Services
final db = FirebaseFirestore.instance;

//Firebase Authentication Services
final auth = FirebaseAuth.instance;

// This ("loggenInUser") Is Future Value Of Current User
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userId});

  final String userId;
  //Screen id For Routes
  static final String id = "ChatPage";
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

String? messageContent;

class _ChatScreenState extends State<ChatScreen> {
  //Messages Stream
  final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection('Messages')
      .orderBy('timestamp')
      .snapshots();

// Execute getCurrentUser At The Start of Screen
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                    print(loggedInUser?.email);
                    FirebaseFirestore.instance.collection("Messages").add(
                      {
                        "messageContent": messageContent,
                        "sender": "${loggedInUser?.email}",
                        "timestamp": FieldValue.serverTimestamp()
                      },
                    );
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
