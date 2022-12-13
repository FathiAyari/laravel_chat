import 'package:auth/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

const d_red = const Color(0xFF00695C);
const primaryColor = Color(0xFF00695C);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
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
      home: SplashScreen(),
    );
  }
}
