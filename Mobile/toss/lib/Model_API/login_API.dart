import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Constants/uri.dart';

class LoginAPI {
  LoginAPI._();
  static Future<dynamic> login(String username, String password) async {
    try {
      if (username.isNotEmpty && password.isNotEmpty) {
        return await http.post(Uri.parse(URI.BASE_URI + URI.USER_LOGIN),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode({"username": username, "password": password}));
      }
    } catch (e) {
      throw Exception('Đăng nhập thất bại');
    }
  }
}
