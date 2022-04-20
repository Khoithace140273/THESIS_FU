import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../Constants/uri.dart';
import '../Model/Entity/user_model.dart';

class EditUserProfileAPI {
  EditUserProfileAPI._();

  static Future<dynamic> editUserProfile(UserModel userEditProfile) async {
    try {
      if (userEditProfile.identityCard!.isNotEmpty &&
          userEditProfile.email!.isNotEmpty &&
          userEditProfile.phoneNumber!.isNotEmpty &&
          userEditProfile.location!.isNotEmpty &&
          userEditProfile.cwtId != 0 &&
          userEditProfile.fullname!.isNotEmpty) {
        String dob = DateFormat('yyyy-MM-dd').format(userEditProfile.dateofbirth!);
        final response = await http.post(
            Uri.parse(URI.BASE_URI + URI.USER_REGISTER),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode({
              "username": userEditProfile.username,
              "dayOfBirth": dob,
              "identityCard": userEditProfile.identityCard,
              "email": userEditProfile.email,
              "phoneNumber": userEditProfile.phoneNumber,
              "gender": userEditProfile.gender,
              "location": userEditProfile.location,
              "cwtId": userEditProfile.cwtId,
              "fullname": userEditProfile.fullname,
              "photoUrl": ""
            }));
        return response;
      }
    } catch (e) {
      throw Exception('Cập nhật thông tin thất bại');
    }
  }
}
