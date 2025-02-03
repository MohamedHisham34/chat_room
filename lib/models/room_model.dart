import 'package:chat_room/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference roomReference = db.collection('Rooms');

//Room Members Stream (Used For Checking The Number Of Participated Members)
Stream<DocumentSnapshot> roomMembersStream({required String roomNumber}) {
  return roomReference.doc(roomNumber).snapshots();
}

class RoomClass {
  final String? roomName;
  final bool? isCompleted;

  RoomClass({
    required this.roomName,
    required this.isCompleted,
  });

  Map<String, dynamic> roomData() {
    return {"roomNumber": roomName, "isCompleted": isCompleted};
  }
}
