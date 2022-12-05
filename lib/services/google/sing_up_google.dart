import 'GoogleSignInApi.dart';

void SignUpWithGoogle() async {
  try {
    final data = await GoogleSignInApi.login();
    print(data);
  } catch (e) {
    print(e.toString());
  }
}
