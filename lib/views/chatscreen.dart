// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, prefer_typing_uninitialized_variables, must_be_immutable, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, empty_statements, prefer_final_fields, unnecessary_string_escapes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/message_controller.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/services/database.dart';


class ChatScreen extends StatefulWidget {
  final UserModel? userList;
  const ChatScreen({Key? key, this.userList}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);



    

    /* getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  } */

  String chatRoomId = ''; /* = (widget.userList!.email!,firebaseUser!.email!);
 */
    
        Get.put(MessageController(chatRoomId));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(widget.userList!.name!),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: Column(
                children: [
                  GetX<MessageController>(
                    
                    builder: (MessageController controller) {
                      
                      if (controller.messageList != null) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: controller.messageList.length,
                            itemBuilder: (context, index) {
                              return  Column(
                                crossAxisAlignment:
                                    controller.messageList[index].senderUid! ==
                                            firebaseUser!.uid
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.end,
                                children: [
                                  /* Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: controller.messageList[index]
                                                .senderUid! ==
                                            firebaseUser!.uid
                                        ? Colors.lightBlue
                                        : Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        controller
                                            .messageList[index].messageText!,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ),
                                    ),
                                  ), */
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    margin: EdgeInsets.all(16),
                                    constraints: BoxConstraints(maxWidth: 140),
                                    decoration: BoxDecoration(
                                      color: controller.messageList[index]
                                                  .senderUid! ==
                                              firebaseUser!.uid
                                          ? Colors.grey[100]
                                          // ignore: deprecated_member_use
                                          : Colors.green[900],
                                      borderRadius: controller
                                                  .messageList[index]
                                                  .senderUid! ==
                                              firebaseUser!.uid
                                          ? borderRadius.subtract(
                                              BorderRadius.only(
                                                  bottomRight: radius))
                                          : borderRadius.subtract(
                                              BorderRadius.only(
                                                  bottomLeft: radius)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: controller.messageList[index]
                                                  .senderUid! ==
                                              firebaseUser!.uid
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          controller
                                            .messageList[index].messageText!,
                                          style: TextStyle(
                                              color: controller.messageList[index]
                                                  .senderUid! ==
                                              firebaseUser!.uid
                                                  ? Colors.black
                                                  : Colors.white),
                                          textAlign: controller.messageList[index]
                                                  .senderUid! ==
                                              firebaseUser!.uid
                                              ? TextAlign.end
                                              : TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      } else {
                        return Text("loading...");
                      }
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Enter your message',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (messageController.text != null) {
                      DataBase().sendMessage(
                        chatRoomId,
                        messageController.text,
                      );
                      messageController.clear();
                    }
                    ;
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.black,
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
