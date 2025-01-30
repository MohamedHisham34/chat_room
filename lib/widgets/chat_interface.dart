import 'package:chat_room/main.dart';
import 'package:chat_room/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatInterface extends StatefulWidget {
  const ChatInterface({super.key, required this.docs, required this.itemCount});

  final List<QueryDocumentSnapshot<Object?>>? docs;
  final int itemCount;

  @override
  State<ChatInterface> createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        // Checking If the Message Send By The Current User
        if (widget.docs?[index]['sender'] == uAuth.currentUser?.email) {
          //Viewing The Message with Right alignment
          // (If the Current User Send This Message)

          return message_bubble(
              snapshotSender: widget.docs?[index]['sender'],
              snapshotMessageContent: widget.docs?[index]['messageContent'],
              isSender: true,
              color: Colors.blue);
        }
        //Viewing The Message with Left alignment
        // (If Not The Current User Send This Message)
        return message_bubble(
            snapshotSender: widget.docs?[index]['sender'],
            snapshotMessageContent: widget.docs?[index]['messageContent'],
            isSender: false,
            color: Colors.grey);
      },
    );
    ;
  }
}
