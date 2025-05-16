// ignore_for_file: sort_child_properties_last

import 'package:chat_room/screens/main_app/test_calls.dart';
import 'package:chat_room/services/call_service.dart';
import 'package:flutter/material.dart';

class TestFields extends StatelessWidget {
  static const String id = "TestFields";
  const TestFields({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'User ID',
                hintText: 'Enter your ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                CallService _callService = CallService();

                _callService.onUserLogin(idController.text, nameController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TestCalls(
                      userId: idController.text,
                      userName: nameController.text,
                    ),
                  ),
                );
              },
              child: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
