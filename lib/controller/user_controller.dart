// ignore_for_file: prefer_final_fields, unnecessary_this, invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/services/database.dart';

class UserController extends GetxController {
var userList = <UserModel>[].obs;
  List<dynamic> get user =>userList.value;

 @override
  void onInit() {
   userList.bindStream(DataBase().getUser());
    super.onInit();
  }

  

  


  }
