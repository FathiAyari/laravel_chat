import 'dart:io';

import 'package:auth/ressources/dimensions/dimensions.dart';
import 'package:auth/services/auth_services/sign_in_services.dart';
import 'package:auth/view/authentication/sign_up/sign_up.dart';
import 'package:auth/view/authentication/signin/components/input_field.dart';
import 'package:auth/view/components/action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';
import '../../components/alert_dialog.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> avoidReturnButton() async {
    Alerts.alertDialog(
        context,
        "Are you sure you want to exit ?",
        "assets/logooo.png",
        () {
          exit(0);
        },
        "Oui",
        () {
          Navigator.pop(context);
        },
        "Non");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: avoidReturnButton,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: Constants.screenHeight * 0.95,
              child: Column(
                children: [
                  Container(
                    height: Constants.screenHeight * 0.2,
                    child: Image.asset('assets/auth.png'),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Change starts here",
                          style: GoogleFonts.poppins(
                            color: d_red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Save your progress to access your personal training program!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InputField(
                      controller: emailController,
                      label: "Email",
                      prefixWidget: Icon(Icons.email),
                      textInputType: TextInputType.emailAddress),
                  InputField(
                      controller: passwordController,
                      label: "Password",
                      prefixWidget: Icon(Icons.visibility_off),
                      textInputType: TextInputType.text),
                  ActionButton(
                    label: "Login",
                    color: d_red,
                    onPressed: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Login with ",
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        SignInServices.signInWithfaceBookService().then((value) =>
                            print("------------------------------------${value.photoUrl}------------------------------------"));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Color(0xFF576dff),
                        padding: EdgeInsets.all(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.facebook),
                          SizedBox(width: 10),
                          Text(
                            'FACEBOOK',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        SignInServices.signInWithGoogleService().then((value) =>
                            print("------------------------------------${value.photoUrl}------------------------------------"));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Colors.white,
                        padding: EdgeInsets.all(13),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/google.png',
                            height: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'GOOGLE',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return SignUpScreen();
                      }));
                    },
                    child: Text(
                      "Create account ?",
                      style: TextStyle(color: primaryColor),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
