
// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:todo_app/models/message.dart';
import 'package:todo_app/services/database.dart';

class MessageController extends GetxController {
var messageList = <MessageModel>[].obs;
  String? chatRoomId;
  List<dynamic> get user =>messageList.value;
  MessageController(this.chatRoomId);

  @override
  void onInit() {
   messageList.bindStream(DataBase().getMessages(chatRoomId!));
    super.onInit();
  } 

  


  

  


  }