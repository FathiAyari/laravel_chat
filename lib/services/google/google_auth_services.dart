import 'GoogleSignInApi.dart';

class GoogleAuthServices{
 static Future<bool> SignInWithGoogle() async {
    try {
      final data = await GoogleSignInApi.login();
      print("------------------------------------------${data}");
      return true;
    } catch (e) {
      print(e.toString());
      return false;

    }
  }
  void SignOutGoogle() async {
    try {
      final data = await GoogleSignInApi.logout();
      print("------------------------------------------${data}");
    } catch (e) {
      print(e.toString());
    }
  }

}