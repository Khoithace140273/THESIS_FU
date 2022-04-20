import 'dart:convert';
import 'package:toss/Constants/global.dart';
import 'package:toss/Model/nearest_hospital_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Entity/user_model.dart';
import '../Model_API/hospital_API.dart';
import '../View/nearest_hospital_view.dart';

class LoginPresenter {
  NearestHospitalModel? _model;
  NearestHospitalView? _view;

  NearestHospitalView get view => _view!;

  setView(NearestHospitalView value) {
    _view = value;
  }

  NearestHospitalModel get model => _model!;

  NearestHospitalPresenter() {
    _model = NearestHospitalModel();
  }

  Future<UserModel?> handleGetHospital(double longitude, double latitude) async {
    _view!.updateLoading();
    try {
      final response = await HospitalAPI.getHospital(longitude, latitude);
      final loggedInUser = UserModel.fromMap(jsonDecode(response.body));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('username', loggedInUser.username!);
      Global.user = loggedInUser;
      return loggedInUser;
    } catch (e) {
      throw Exception('Tên đăng nhập hoặc mật khẩu không đúng');
    } finally {
      _view!.updateLoading();
    }
  }
}
