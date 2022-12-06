import 'package:auth/services/google/google_auth_services.dart';
import 'package:auth/view/home_screen/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

const d_red = const Color(0xFF00695C);
const primaryColor = Color(0xFF00695C);

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: WelcomePage(),
    );
  }
}

