// ignore_for_file: constant_identifier_names

import 'package:chat_room/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference roomReference = db.collection('Rooms');

//Room Members Stream (Used For Checking The Number Of Participated Members)
Stream<DocumentSnapshot> roomMembersStream({required String roomNumber}) {
  return roomReference.doc(roomNumber).snapshots();
}

class RoomClass {
  static const firebaseField_roomName = "roomNumber";
  static const firebaseField_isCompleted = "isCompleted";
  final String? roomName;
  final bool? isCompleted;

  RoomClass({
    required this.roomName,
    required this.isCompleted,
  });

  Map<String, dynamic> roomData() {
    return {
      firebaseField_roomName: roomName,
      firebaseField_isCompleted: isCompleted
    };
  }
}
