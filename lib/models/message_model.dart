import 'package:chat_room/models/Room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference messageReference({required String roomNumber}) {
  return roomReference.doc(roomNumber).collection('Messages');
}

//Messages Stream
Stream<QuerySnapshot> messageStream({required String roomNumber}) {
  return messageReference(roomNumber: roomNumber)
      .orderBy('timestamp')
      .snapshots();
}

class MessageModel {
  final String? messageContent;
  final String? sender;
  final FieldValue? timestamp;

  MessageModel({
    required this.messageContent,
    required this.sender,
    required this.timestamp,
  });

  Map<String, dynamic> messageData() {
    return {
      "messageContent": messageContent,
      "sender": sender,
      "timestamp": timestamp
    };
  }
}
