import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Entity/user_model.dart';
import '../Model/user_profile_model.dart';
import '../View/user_profile_view.dart';

class UserProfilePresenter {
  UserProfileModel? _model;
  UserProfileView? _view;

  UserProfileView get view => _view!;

  setView(UserProfileView value) {
    _view = value;
  }

  UserProfileModel get model => _model!;

  UserProfilePresenter() {
    _model = UserProfileModel();
  }

  Future<UserModel?> handleLogin(String username, String password) async {
    _view!.updateLoading();
    try {
      // final response = await LoginAPI.login(username, password);
      // final loggedInUser = UserModel.fromMap(jsonDecode(response.body));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.getString('username');
      return UserModel.empty();
    } catch (e) {
      throw Exception('Tên đăng nhập hoặc mật khẩu không đúng');
    } finally {
      _view!.updateLoading();
    }
  }
}
