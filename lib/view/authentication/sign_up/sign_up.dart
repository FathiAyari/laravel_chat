import 'package:auth/ressources/dimensions/dimensions.dart';
import 'package:auth/services/auth_services/auth_services.dart';
import 'package:auth/services/facebook/facebook_auth_services.dart';
import 'package:auth/services/google/google_auth_services.dart';
import 'package:auth/view/authentication/signin/components/input_field.dart';
import 'package:auth/view/chat/messages_screen.dart';
import 'package:auth/view/components/action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/user.dart';
import '../../../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  var storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text("Create account"),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                          controller: nameController,
                          label: "Full Name",
                          prefixWidget: Icon(Icons.account_circle),
                          textInputType: TextInputType.emailAddress),
                      InputField(
                          controller: emailController,
                          label: "E-mail",
                          prefixWidget: Icon(Icons.email),
                          textInputType: TextInputType.emailAddress),
                      InputField(
                          controller: passwordController,
                          label: "Password",
                          prefixWidget: Icon(Icons.visibility_off),
                          textInputType: TextInputType.text),
                      ActionButton(
                        label: "Sign Up",
                        color: d_red,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            Map<String, dynamic> data = {
                              "name": nameController.text,
                              "email": emailController.text,
                              "password": passwordController.text,
                              "account_type": 1,
                            };
                            AuthServices().signUp(data).then((value) {
                              if (value) {
                                setState(() {
                                  loading = false;
                                });
                                nameController.clear();
                                passwordController.clear();
                                emailController.clear();
                                Navigator.of(context).push(MaterialPageRoute(builder: (contet) => MessagesScreen()));
                              } else {
                                setState(() {
                                  loading = false;
                                });
                                final snackBar = SnackBar(
                                  margin: EdgeInsets.all(1),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  duration: Duration(seconds: 5),
                                  action: SnackBarAction(
                                    label: 'Cancel',
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                    },
                                  ),
                                  content: Container(
                                    height: Constants.screenHeight * 0.03,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.015),
                                      child: Text("User exists with this mail"),
                                    ),
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            });
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sign Up with ",
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            FaceBookApis.getDataFromFacebook().then((value) {
                              setState(() {
                                loading = true;
                              });
                              Map<String, dynamic> data = {
                                "name": value.name,
                                "email": value.email,
                                "avatar": value.avatar,
                                "account_type": 3,
                              };
                              AuthServices().signUp(data).then((value) {
                                if (value) {
                                  setState(() {
                                    loading = false;
                                  });
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MessagesScreen()));
                                } else {
                                  setState(() {
                                    loading = false;
                                  });

                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MessagesScreen()));
                                }
                              });
                            });
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
                            GoogleAuthServices().getDataFromGoogle().then((value) {
                              if (value.name != null) {
                                setState(() {
                                  loading = true;
                                });
                                Map<String, dynamic> data = {
                                  "name": value.name,
                                  "email": value.email,
                                  "avatar": value.avatar,
                                  "account_type": 2,
                                };
                                AuthServices().signUp(data).then((value) {
                                  if (value) {
                                    setState(() {
                                      loading = false;
                                    });

                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MessagesScreen()));
                                  }
                                });
                              }
                            });
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
                    ],
                  ),
                ),
              ),
              loading
                  ? Container(
                      child: Center(
                        child: Container(
                          decoration:
                              BoxDecoration(color: primaryColor.withOpacity(0.3), borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      color: Colors.white.withOpacity(0.3),
                    )
                  : Container()
            ],
          )),
    );
  }
}
