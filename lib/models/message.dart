import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? messageText;
  String? senderUid;
  String? senderEmail;

  MessageModel({this.messageText, this.senderEmail, this.senderUid});

  MessageModel.fromDocumentSnapshot(DocumentSnapshot? documentSnapshot) {
    senderUid = documentSnapshot!["Senderemail"];
    messageText = documentSnapshot["messageText"];
    senderEmail = documentSnapshot["Senderemail"];
  }
}
