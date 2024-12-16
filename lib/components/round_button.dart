// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:chat_room/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class roundButton extends StatelessWidget {
  roundButton(
      {super.key,
      required this.buttontext,
      required this.color,
      required this.function,
      required this.textColor,
      this.textSize});

  final Color color;
  final String buttontext;
  final Function function;
  final Color textColor;
  double? textSize;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      //Navigate (Push) to Registration Screen
      onPressed: () {
        function();
      },
      color: color,
      textColor: textColor,
      child: Text(
        "${buttontext}",
        style: TextStyle(fontSize: textSize ?? 15),
      ),
    );
  }
}
