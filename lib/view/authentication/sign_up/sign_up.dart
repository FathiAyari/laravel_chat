import 'package:auth/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ressources/dimensions/dimensions.dart';
import '../../components/action_button.dart';
import '../signin/components/input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text("Create account"),
      ),
      body:    SingleChildScrollView(
    child: Container(
    height: Constants.screenHeight*0.95,
      child: Column(
        children: [
          Container(
            height: Constants.screenHeight *0.2 ,
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
          ActionButton(label: "Sign up",color: d_red,onPressed: (){},),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Sign up with ",style: TextStyle(color: primaryColor),),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {

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
            child:            ElevatedButton(
              onPressed: () {

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

          TextButton(onPressed: (){

            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return SignUpScreen();
            }));
          }, child: Text("Create account ?",style: TextStyle(color: primaryColor),),)


        ],
      ),
    ),
    ),
    );
  }
}
