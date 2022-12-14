import 'package:auth/ressources/dimensions/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class StartDrawer extends StatelessWidget {
   StartDrawer({Key? key}) : super(key: key);
var user =GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,child: Padding(
        padding:  EdgeInsets.only(top: Constants.screenHeight * 0.1),
        child: Column(children: [

        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(user['avatar']),)
    ],),
      ),);
  }
}
