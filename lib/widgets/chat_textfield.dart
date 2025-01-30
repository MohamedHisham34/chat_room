// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

final myController = TextEditingController();

class ChatTextfield extends StatelessWidget {
  ChatTextfield({
    super.key,
    required this.textValue,
    required this.onSendButtonPress,
  });

  final Function textValue;
  final Function onSendButtonPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: myController,
              onChanged: (value) {
                textValue(value);
              },
            ),
          ),
          TextButton(
            onPressed: () {
              //Assign Values to Message Model
              onSendButtonPress();
              myController.clear();
            },
            child: Text(
              'Send',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
