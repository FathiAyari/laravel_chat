import 'package:auth/data/user.dart';

import 'GoogleSignInApi.dart';

class GoogleAuthServices {
  static Future<User> SignInWithGoogle() async {
    try {
      final data = await GoogleSignInApi.login();

      return User.fromJson({
        "displayName": data!.displayName,
        "email": data.email,
        "photoUrl": data.photoUrl,
      });
    } catch (e) {
      print(e.toString());
      return User();
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
