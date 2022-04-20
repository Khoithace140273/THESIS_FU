import 'Entity/user_model.dart';

class NearestHospitalModel {
  bool? _isLoading;
  UserModel? _user;

  NearestHospitalModel() {
    _isLoading = false;
    _user = UserModel.empty();
  }

  bool get isLoading => _isLoading!;
  set isLoading(bool value) => _isLoading = value;

  UserModel get user => _user!;
  set user(UserModel value) => _user = value;
}
