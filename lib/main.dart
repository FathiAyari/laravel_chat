import 'package:auth/services/google/sing_up_google.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: test(),
    );
  }
}

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            SignUpWithGoogle();
            /*try {
              final result = await FacebookAuth.i.login(permissions: ["public_profile", "email"]);
              if (result.status == LoginStatus.success) {
                final requestData = await FacebookAuth.i.getUserData(fields: "name,email,picture");
                print(requestData);
              }
            } catch (e) {
              print(e.toString());
            }*/
          },
          child: Text("test"),
        ),
      ),
    );
  }
}
