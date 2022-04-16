import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Constants/uri.dart';
import '../Model/Entity/cwt_model.dart';

class CWTAPI {
  static Future<dynamic> getCWTsByDistrict(String districtId) async {
    try {
      final response = await http.get(
          Uri.parse(URI.BASE_URI + URI.GET_CWTS_BY_DISTRICT + districtId),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      return cwtModelFromJson(response.body);
    } catch (e) {
      throw Exception('Lấy thông tin Phường/Xã/Thị trấn thất bại');
    }
  }
}
