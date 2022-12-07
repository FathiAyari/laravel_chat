import 'dart:convert';

import 'package:http/http.dart' as http;


class CallApi {
  String baseURL = "http://192.168.154.86:8000/api/";

postData(data, apiUrl) async {
    var fullUrl = baseURL + apiUrl + await _getToken();
    return await http.post(Uri.parse(fullUrl), body: jsonEncode(data), headers: _setHeaders());
  }

  putData(data, apiUrl) async {
    var fullUrl = baseURL + apiUrl + await _getToken();
    return await http.put(Uri.parse(fullUrl), body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = baseURL + apiUrl + await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  deleteData(apiUrl) async {
    var fullUrl = baseURL + apiUrl + await _getToken();
    return await http.delete(Uri.parse(fullUrl), headers: _setHeaders());
  }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Connection": "Keep-Alive",
  };
  _getToken() async {
/*    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';*/
  }
}