// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Testing extends StatefulWidget {
  static final String id = "TestScreen";
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  var db = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> data = [];

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Messages').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Test'),
        ),
        body: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error Getting Data");
            }
            ;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            ;

            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                try {
                  return Card(
                    color: Colors.grey,
                    child: ListTile(
                      title: Text(
                        "${snapshot.data?.docs[index]["messageContent"]}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${snapshot.data?.docs[index]["sender"]}",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              },
            );
          },
          stream: _usersStream,
        )

// To FETCH THE DOCUMENT DATA IN THE DEBUG CONSOLE
//========================================================

// db.collection("col_name").get().then(
//   (querySnapshot) {
//     print("Successfully completed");
//     for (var docSnapshot in querySnapshot.docs) {
//       print('${docSnapshot.id} => ${docSnapshot.data()}');
//     }
//   },
//   onError: (e) => print("Error completing: $e"),
// );

// // TO GET DOCUMENT DATA IN GRIDVIEW
// //==========================================

// getData() async{
//   QuerySnapshot querySnapshot = await db.collection("col_name").get();

// // THIS "data" IS A LIST OF TYPE QUARYDOCUMENTSNAPSHOT
//   data.addAll(querySnapshot.docs);
// }

//  GridView.builder(
        //   itemCount: data.length,
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2, mainAxisSpacing: 20),
//   itemBuilder: (context, i) {
//     try {
//       return Text("${data[i]["messageContent"]}");
//     } catch (e) {
//       print(e);
//     }
//   },
// ),
        );
  }
}
