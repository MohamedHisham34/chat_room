// ignore_for_file: prefer_const_constructors

import 'package:chat_room/firebase_options.dart';
import 'package:chat_room/screens/main_app/create_room_screen.dart';
import 'package:chat_room/screens/main_app/join_room_screen.dart';
import 'package:chat_room/screens/authentication/login_screen.dart';

import 'package:chat_room/screens/main_app/rooms_screen.dart';

import 'package:chat_room/screens/authentication/registration_screen.dart';
import 'package:chat_room/screens/main_app/test_calls.dart';
import 'package:chat_room/screens/main_app/test_fields.dart';
import 'package:chat_room/screens/main_app/welcome_screen.dart';

import 'package:chat_room/screens/testing_firebase_functions.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

FirebaseAuth uAuth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;

final GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  // call the useSystemCallingUI
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp());
  });
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      //Test Firebase Connection
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Text("Done");
          }
          return Text("Loading");
        },
      ),
      initialRoute: TestFields.id,
      routes: {
        //WelcomeScreen Route
        WelcomeScreen.id: (context) => WelcomeScreen(),

        //Login and Registration screen
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),

        //Test Page
        Testing.id: (context) => Testing(),

        //Rooms Screen
        RoomsScreen.id: (context) => RoomsScreen(),
        // Create Room
        CreateRoomScreen.id: (context) => CreateRoomScreen(),
        // Join Room
        JoinRoomScreen.id: (context) => JoinRoomScreen(),
        
        TestFields.id: (context) => TestFields(),
      },
    );
  }
}
