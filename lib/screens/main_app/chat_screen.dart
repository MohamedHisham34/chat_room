// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print
import 'package:chat_room/models/room_model.dart';
import 'package:chat_room/screens/main_app/rooms_screen.dart';
import 'package:chat_room/widgets/chat_interface.dart';
import 'package:chat_room/widgets/chat_textfield.dart';
import 'package:chat_room/constants/Colors.dart';
import 'package:chat_room/models/message_model.dart';
import 'package:chat_room/screens/main_app/create_room_screen.dart';
import 'package:chat_room/services/auth_service.dart';
import 'package:chat_room/widgets/reusable_stream_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

AuthService authService = AuthService();

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.roomNumber});

  final String roomNumber;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void dispose() {
    print("Room Deleted From Database");
    super.dispose();
  }

  void _navigateToRoomsScreen() {
    Navigator.pushReplacementNamed(
        context, RoomsScreen.id); // Navigate to Rooms Screen
  }

  FieldValue currentTime = FieldValue.serverTimestamp();

  String? messageContent;

  @override
  Widget build(BuildContext context) {
    // App Layout
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Exit Room?'),
                content: Text(
                    "Are You Sure You Want To Exit This Room The Chat Data Will Be Deleted "),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _navigateToRoomsScreen();
                        },
                        child: Text("Yes"),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("No"))
                    ],
                  )
                ],
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryOrangeColor,
          centerTitle: true,
          title: const Text('Chat Room'),
        ),

        // App background
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/chat-background.jpg'),
              fit: BoxFit.cover,
            ),
          ),

          // Chat Screen InterFace
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Check the Participated Members
              ReusableStreamBuilder(
                stream: roomMembersStream(roomNumber: roomNumber),
                content: (snapshot) {
                  bool? isCompleted = snapshot.data?.get('isCompleted');

                  return Container(
                    child: Text(
                      isCompleted == true ? "Members 2/2" : "Members 1/2",
                      textAlign: TextAlign.center,
                    ),
                    color: isCompleted == true ? Colors.green : Colors.red,
                  );
                },

                //viewing The Room ID
              ),
              Text(
                "Room Number" + " : " + "${widget.roomNumber}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),

              // Chat Messages InterFace
              Expanded(
                child: ReusableStreamBuilder(
                  content: (snapshot) {
                    return ChatInterface(
                        docs: snapshot.data.docs,
                        itemCount: snapshot.data.docs.length);
                  },
                  stream: messageStream(roomNumber: widget.roomNumber),
                ),
              ),

              // Typing Your Message interface Textfield
              // Send Message Button

              ChatTextfield(
                textValue: (value) {
                  messageContent = value;
                },
                onSendButtonPress: () {
                  //Assign Values to Message Model

                  MessageModel messageModel = MessageModel(
                      messageContent: messageContent,
                      sender: authService.currentUser?.email,
                      timestamp: currentTime);

                  //Adding User Messages to FireBase DataBase
                  messageReference(roomNumber: widget.roomNumber)
                      .add(messageModel.messageData());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
