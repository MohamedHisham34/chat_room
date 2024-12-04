// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';

class CreateRoomScreen extends StatelessWidget {
  static final String id = "CreateRoomScreen";
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Room'),
      ),
      body: Container(),
    );
  }
}
