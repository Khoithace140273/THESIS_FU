import 'package:toss/Model/Entity/cwt_model.dart';
import 'package:toss/Model/Entity/district_model.dart';
import 'package:toss/Model/Entity/province_model.dart';

import 'Entity/user_model.dart';

class EditUserProfileModel {
  bool? _isLoading;
  UserModel? _user;
  List<ProvinceModel>? _provinceList;
  List<DistrictModel>? _districtList;
  List<CWTModel>? _cwtList;

  EditUserProfileModel() {
    _isLoading = false;
    _user = UserModel.empty();
    _provinceList = List<ProvinceModel>.empty();
    _districtList = List<DistrictModel>.empty();
    _cwtList = List<CWTModel>.empty();
  }

  bool get isLoading => _isLoading!;
  set isLoading(bool value) => _isLoading = value;

  UserModel get user => _user!;
  set user(UserModel value) => _user = value;

  List<ProvinceModel> get provinceList => _provinceList!;
  set provinceList(List<ProvinceModel> value) => _provinceList = value;

  List<DistrictModel> get districtList => _districtList!;
  set districtList(List<DistrictModel> value) => _districtList = value;

  List<CWTModel> get cwtList => _cwtList!;
  set cwtList(List<CWTModel> value) => _cwtList = value;
}
