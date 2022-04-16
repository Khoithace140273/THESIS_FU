import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Constants/uri.dart';
import '../Model/Entity/district_model.dart';

class DistrictAPI {
  static Future<dynamic> getDistrictsByProvince(String provinceId) async {
    try {
      final response = await http.get(
          Uri.parse(URI.BASE_URI + URI.GET_DISTRICTS_BY_PROVINCE + provinceId),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      return districtModelFromJson(response.body);
    } catch (e) {
      throw Exception('Lấy thông tin Quận/Huyện thất bại');
    }
  }
}
