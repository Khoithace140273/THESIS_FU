import 'package:toss/Model/Entity/cwt_model.dart';
import 'package:toss/Model/Entity/district_model.dart';
import 'package:toss/Model/Entity/province_model.dart';
import 'package:toss/Model_API/cwt_API.dart';
import 'package:toss/Model_API/district_API.dart';
import 'package:toss/Model_API/edit_user_profile_API.dart';
import 'package:toss/Model_API/province_API.dart';

import '../Model/Entity/user_model.dart';
import '../Model/edit_user_profile_model.dart';
import '../View/edit_user_profile_view.dart';

class EditUserProfilePresenter {
  EditUserProfileModel? _model;
  EditUserProfileView? _view;

  EditUserProfileView get view => _view!;

  setView(EditUserProfileView value) {
    _view = value;
  }

  EditUserProfileModel get model => _model!;

  EditUserProfilePresenter() {
    _model = EditUserProfileModel();
  }

  void handleOnChangeInput() {
    view.updateViewStatusValidation();
  }

  Future<bool> handleEditUserProfile(UserModel userEditProfile) async {
    _view!.updateLoading();
    try {
      _model!.user = userEditProfile;
      final response = await EditUserProfileAPI.editUserProfile(_model!.user);
      return (response.statusCode == 200);
    } catch (e) {
      print(e.toString());
      throw Exception('Chỉnh sửa thông tin cá nhân không thành công');
    } finally {
      _view!.updateLoading();
    }
  }

  Future<List<ProvinceModel>> handleProvinceGetting() async {
    _view!.updateLoading();
    try {
      final response = await ProvinceAPI.getProvinces();
      return response;
    } catch (e) {
      print(e.toString());
      throw Exception('Không thể lấy thông tin Tỉnh/Thành phố');
    } finally {
      _view!.updateLoading();
    }
  }

  Future<List<DistrictModel>> handleDistrictGettingByProvinceId(
      String provinceId) async {
    _view!.updateLoading();
    try {
      final response = await DistrictAPI.getDistrictsByProvince(provinceId);
      return response;
    } catch (e) {
      print(e.toString());
      throw Exception('Không thể lấy thông tin Quận/Huyện');
    } finally {
      _view!.updateLoading();
    }
  }

  Future<List<CWTModel>> handleCWTGettingByDistrictId(String districtId) async {
    _view!.updateLoading();
    try {
      final response = await CWTAPI.getCWTsByDistrict(districtId);
      return response;
    } catch (e) {
      print(e.toString());
      throw Exception('Không thể lấy thông tin Phường/Xã/Thị trấn');
    } finally {
      _view!.updateLoading();
    }
  }
}
