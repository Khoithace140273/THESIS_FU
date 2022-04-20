import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Constants/uri.dart';

class HospitalAPI {
  HospitalAPI._();
  static Future<dynamic> getHospital(double longitude, double latitude) async {
    try {
        return await http.post(Uri.parse(URI.BASE_URI + URI.USER_LOGIN),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode({"username": longitude, "password": latitude}));

    } catch (e) {
      throw Exception('Đăng nhập thất bại');
    }
  }
}
