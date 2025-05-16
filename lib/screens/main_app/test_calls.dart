// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:chat_room/services/call_service.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class TestCalls extends StatefulWidget {
  static String id = "TestCalls";
  final String userId;
  final String userName;
  const TestCalls({super.key, required this.userId, required this.userName});

  @override
  State<TestCalls> createState() => _TestCallsState();
}

class _TestCallsState extends State<TestCalls> {
  refresh() {
    setState(() {});
  }

  TextEditingController _idCon = TextEditingController();
  TextEditingController _NameCon = TextEditingController();

  CallService callService = CallService();
  @override
  void initState() {
    callService.onUserLogin(widget.userId, widget.userName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
      body: SafeArea(
        child: SafeArea(
          child: Column(
            children: [
              Text("Call Someone"),
              TextField(
                controller: _idCon,
              ),
              TextField(
                controller: _NameCon,
              ),
              ElevatedButton(
                onPressed: () {
                  refresh();
                },
                child: Text("test"),
              ),
              ZegoSendCallInvitationButton(
                invitees: [ZegoUIKitUser(id: _idCon.text, name: _NameCon.text)],
                isVideoCall: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
