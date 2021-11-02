// ignore_for_file: prefer_final_fields, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/message.dart';
import 'package:todo_app/models/user.dart';

class DataBase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var firebaseUser = FirebaseAuth.instance.currentUser;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(firebaseUser!.uid).set({
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<UserModel>> getUser() {
    return _firestore
        .collection("users")
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> userList = [];
      query.docs.forEach((element) {
        userList.add(UserModel.fromDocumentSnapshot(element));
      });
      print(userList.length);
      
      return userList;
    });
  }

  Future<bool> sendMessage(String chatRoomId, String message,)async{
    try {
      await _firestore.collection("chats").doc(chatRoomId).collection("messages").
      add({
        "messageText": message,
        "Senderemail":firebaseUser!.email,
        "Senderuid": firebaseUser!.uid,

      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }

  }

  Stream<List<MessageModel>> getMessages(String chatRoomId) {
    return _firestore
        .collection("chats").doc(chatRoomId).collection('messages')
        .snapshots()
        .map((QuerySnapshot query) {
      List<MessageModel> messageList = [];
      query.docs.forEach((element) {
        messageList.add(MessageModel.fromDocumentSnapshot(element));
      });
      print(messageList.length);
      print('aaa');
      return messageList;
    });
  }



}
