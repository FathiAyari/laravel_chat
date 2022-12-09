import 'dart:async';


import 'package:auth/view/authentication/signin/sign_in_screen.dart';
import 'package:auth/view/welcome_sreen/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../ressources/dimensions/dimensions.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplasScreenState createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplashScreen> {
  var seen = GetStorage().read("seen");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 4), () => Get.to(seen == 1 ? SignInScreen() : WelcomePage()));
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
              Image.asset(
                "assets/images/logo.png",
                height: Constants.screenHeight * 0.3,
                width: Constants.screenWidth * 0.7,
              ),
              Lottie.asset(
                "assets/images/pharmacy.json",
                height: Constants.screenHeight * 0.2,
              ),
              Lottie.asset(
                "assets/images/loading.json",
                height: Constants.screenWidth * 0.2,
              )
            ],
          ),
        ));
  }
}