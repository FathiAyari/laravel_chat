import 'dart:async';

import 'package:auth/view/authentication/signin/sign_in_screen.dart';
import 'package:auth/view/chat/messages_screen.dart';
import 'package:auth/view/welcome_sreen/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../ressources/dimensions/dimensions.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplasScreenState createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplashScreen> {
  var seen = GetStorage().read("seen");
  var auth = GetStorage().read("auth");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => seen == 1 ? (auth == 1 ? MessagesScreen() : SignInScreen()) : WelcomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Lottie.asset(
                "assets/chat.json",
                height: Constants.screenHeight * 0.3,
              ),
              Lottie.asset(
                "assets/loading.json",
                height: Constants.screenWidth * 0.2,
              )
            ],
          ),
        ));
  }
}
