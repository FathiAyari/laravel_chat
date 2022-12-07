import 'package:auth/services/google/google_auth_services.dart';

import '../../data/user.dart';
import '../facebook/facebook_auth_services.dart';

class SignInServices {
  static Future<User> signInWithfaceBookService() async {
    User user = await FaceBookApis.signInWithFacebook();

    return user;
  }

  static Future<User> signInWithGoogleService() async {
    User user = await GoogleAuthServices.SignInWithGoogle();

    return user;
  }
}
