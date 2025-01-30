import 'dart:ui';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';

class message_bubble extends StatelessWidget {
  const message_bubble(
      {super.key,
      required this.snapshotMessageContent,
      required this.isSender,
      required this.color,
      required this.snapshotSender});

  final String snapshotMessageContent;
  final String snapshotSender;
  final bool isSender;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: isSender
            ? CrossAxisAlignment.end
            :
            //
            CrossAxisAlignment.start,
        //
        children: [
          Text("${snapshotSender}"),
          BubbleSpecialThree(
            text: "${snapshotMessageContent}",
            isSender: isSender,
            color: color,
            tail: true,
            textStyle: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ]);
  }
}
