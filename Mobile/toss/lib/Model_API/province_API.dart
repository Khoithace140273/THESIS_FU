import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Constants/uri.dart';
import 'package:toss/Model/Entity/province_model.dart';

class ProvinceAPI {
  ProvinceAPI._();
  static Future<dynamic> getProvinces() async {
    try {
      final response = await http.get(
          Uri.parse(URI.BASE_URI + URI.GET_PROVINCES),
          );
      return provinceModelFromJson(response.body);
    } catch (e) {
      throw Exception('Lấy thông tin Tỉnh/Thành phố thất bại');
    }
  }

  static List<ProvinceModel> parseProvinces(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ProvinceModel>((json) => ProvinceModel.fromJson(json))
        .toList();
  }


}
