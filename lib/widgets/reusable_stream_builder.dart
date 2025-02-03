import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReusableStreamBuilder extends StatelessWidget {
  const ReusableStreamBuilder(
      {super.key, required this.stream, required this.content});

  final Stream stream;
  final Widget Function(AsyncSnapshot snapshot) content;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error Getting documents");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }

        return content(snapshot);
      },
    );
  }
}
