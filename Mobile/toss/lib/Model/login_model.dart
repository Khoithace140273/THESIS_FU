import 'Entity/user_model.dart';

class LoginModel {
  bool? _isLoading;
  UserModel? _user;

  LoginModel() {
    _isLoading = false;
    _user = UserModel.empty();
  }

  bool get isLoading => _isLoading!;
  set isLoading(bool value) => _isLoading = value;

  UserModel get user => _user!;
  set user(UserModel value) => _user = value;
}
