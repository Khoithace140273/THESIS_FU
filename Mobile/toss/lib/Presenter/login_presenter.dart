import 'dart:convert';
import 'package:toss/Constants/global.dart';
import 'package:toss/Model/Entity/register_user_model.dart';
import 'package:toss/Model/login_model.dart';
import 'package:toss/Model_API/login_API.dart';
import 'package:toss/View/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Entity/user_model.dart';

class LoginPresenter {
  LoginModel? _model;
  LoginView? _view;

  LoginView get view => _view!;

  setView(LoginView value) {
    _view = value;
  }

  LoginModel get model => _model!;

  LoginPresenter() {
    _model = LoginModel();
  }

  void handleOnChangeInput() {
    view.updateViewStatusValidation();
  }

  Future<UserModel?> handleLogin(String username, String password) async {
    _view!.updateLoading();
    try {
      final response = await LoginAPI.login(username, password);
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
