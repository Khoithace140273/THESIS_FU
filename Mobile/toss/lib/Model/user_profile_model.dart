import 'package:toss/Constants/global.dart';

import 'Entity/user_model.dart';

class UserProfileModel{
  bool? _isLoading;
  UserModel? _user;

  UserProfileModel() {
    _isLoading = false;
    _user = Global.user!;
  }

  bool get isLoading => _isLoading!;
  set isLoading(bool value) => _isLoading = value;

  UserModel get user => _user!;
  set user(UserModel value) => _user = value;
}