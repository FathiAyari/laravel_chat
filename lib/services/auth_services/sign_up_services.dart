import 'package:auth/services/auth_services/call_api_dart.dart';
import 'package:http/http.dart' as http;

class SignUpServices {
  static Future<http.Response> register(String firstname, String email, String password) async {
    Map data = {
      "firstname": firstname,
      "email": email,
      "password": password,
    };
    http.Response response = CallApi().postData(data, 'auth/register');
    print(response.body);
    return response;
  }
}
