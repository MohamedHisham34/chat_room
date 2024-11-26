// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Cardtest extends StatelessWidget {
  static final id = "test";
  const Cardtest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.centerRight,
            child: Card(
              child: Text("data"),
            ),
          );
        },
      ),
    );
  }
}
