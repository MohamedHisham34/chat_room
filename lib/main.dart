// ignore_for_file: prefer_const_constructors

import 'package:chat_room/firebase_options.dart';
import 'package:chat_room/screens/create_room_screen.dart';
import 'package:chat_room/screens/join_room_screen.dart';
import 'package:chat_room/screens/rooms_screen.dart';
import 'package:chat_room/screens/testing_firebase_functions.dart';
import 'package:chat_room/screens/login_screen.dart';
import 'package:chat_room/screens/registration_screen.dart';
import 'package:chat_room/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_room/screens/test.dart';

void main() async {
  // Firebase Connection
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: WelcomeScreen.id,
      routes: {
        //WelcomeScreen Route
        WelcomeScreen.id: (context) => WelcomeScreen(),

        //Login and Registration screen
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),

        //Chat Screen
        //Test Page
        Testing.id: (context) => Testing(),
        Cardtest.id: (context) => Cardtest(),

        //Rooms Screen
        RoomsScreen.id: (context) => RoomsScreen(),
        // Create Room
        CreateRoomScreen.id: (context) => CreateRoomScreen(),
        // Join Room
        JoinRoomScreen.id: (context) => JoinRoomScreen(),
      },
    );
  }
}
