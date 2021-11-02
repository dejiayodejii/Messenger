// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, must_be_immutable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/user_controller.dart';
import 'package:todo_app/services/userauth.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/views/chatscreen.dart';

class HomeScreeen extends GetWidget<UserController> {
  UserController userController = Get.put(UserController());

  
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text('HomeScreen'),
        centerTitle: true,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
              onPressed: () {
                Get.find<Authentication>().signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Flexible(
          child: Column(
            children: [
              Obx(
                () => ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: userController.userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          
                          Get.to(() => ChatScreen(userList: userController.userList[index] ));
                        },
                        leading: CircleAvatar(
                          radius: 25,
                          child: IconButton(
                            onPressed: (){}, 
                          icon: Icon(Icons.photo)),
                          //backgroundImage: NetworkImage(user.urlAvatar),
                        ),
                        title: Text(
                          userController.userList[index].name!,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        subtitle: Text(userController.userList[index].email!,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        trailing: Text(formattedDate,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black
                        ),),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
