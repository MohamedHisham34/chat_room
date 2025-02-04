// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:chat_room/constants/text_field_decoration.dart';
import 'package:chat_room/constants/wave_clipper.dart';
import 'package:chat_room/screens/main_app/rooms_screen.dart';
import 'package:chat_room/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static final String id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 200,
                color: Colors.orange,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              textAlign: TextAlign.center,
              'Welcome',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              'Login To Your Account',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  email = value;
                },
                decoration: TextFieldDecoration),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  password = value;
                },
                decoration: TextFieldDecoration),
            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                  Text("Remember me"),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  //User Login Function
                  onPressed: () async {
                    try {
                      User? user = await authService.signIn(email, password);
                      if (user != null) {
                        print('Signed in as: ${user.email}');
                        Navigator.pushNamed(context, RoomsScreen.id);
                      } else {
                        print('Sign-in failed.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    'Login',
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Do not Have Account'),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
