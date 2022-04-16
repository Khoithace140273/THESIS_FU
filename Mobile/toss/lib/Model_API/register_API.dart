import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toss/Model/Entity/register_user_model.dart';

import '../Constants/uri.dart';

class RegisterAPI {
  RegisterAPI._();

  static Future<dynamic> register(RegisterUserModel userRegister) async {
    try {
      if (userRegister.username!.isNotEmpty &&
          userRegister.password!.isNotEmpty &&
          userRegister.identityCard!.isNotEmpty &&
          userRegister.email!.isNotEmpty &&
          userRegister.phoneNumber!.isNotEmpty &&
          userRegister.location!.isNotEmpty &&
          userRegister.cwtId != 0 &&
          userRegister.fullname!.isNotEmpty) {
        String dob = DateFormat('yyyy-MM-dd').format(userRegister.dateofbirth!);
        final response = await http.post(
            Uri.parse(URI.BASE_URI + URI.USER_REGISTER),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode({
              "username": userRegister.username,
              "password": userRegister.password,
              "dayOfBirth": dob,
              "identityCard": userRegister.identityCard,
              "email": userRegister.email,
              "phoneNumber": userRegister.phoneNumber,
              "gender": userRegister.gender,
              "location": userRegister.location,
              "cwtId": userRegister.cwtId,
              "fullname": userRegister.fullname,
              "photoUrl": ""
            }));
        return response;
      }
    } catch (e) {
      throw Exception('Đăng Ký thất bại');
    }
  }
}
