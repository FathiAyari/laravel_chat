import 'dart:convert';

import 'package:auth/services/auth_services/call_api_dart.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../data/user.dart';

class AuthServices {
  final storage = GetStorage();

  Future<bool> signUp(Map data) async {
    http.Response response = await CallApi().postData(data, 'signup');
    if (response.statusCode == 200) {
      storage.write("auth", 1);
      User user = User.fromJson(jsonDecode(response.body));
      storage.write('user', {
        'name': user.name,
        'email': user.email,
        'avatar': user.avatar,
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signIn(Map data) async {
    http.Response response = await CallApi().postData(data, 'signin');

    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body));
      storage.write("auth", 1);
      print(user.toJson());
      storage.write('user', {
        'name': user.name,
        'email': user.email,
        'avatar': user.avatar,
      });
      return true;
    } else {
      return false;
    }
  }
}
