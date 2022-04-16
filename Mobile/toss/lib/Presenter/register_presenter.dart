import 'dart:convert';
import 'dart:ffi';
import 'package:toss/Model/Entity/cwt_model.dart';
import 'package:toss/Model/Entity/district_model.dart';
import 'package:toss/Model/Entity/province_model.dart';
import 'package:toss/Model/Entity/register_user_model.dart';
import 'package:toss/Model_API/cwt_API.dart';
import 'package:toss/Model_API/district_API.dart';
import 'package:toss/Model_API/province_API.dart';
import '../Model/register_model.dart';
import '../Model_API/register_API.dart';
import '../View/register_view.dart';

class RegisterPresenter {
  RegisterModel? _model;
  RegisterView? _view;

  RegisterView get view => _view!;

  setView(RegisterView value) {
    _view = value;
  }

  RegisterModel get model => _model!;

  RegisterPresenter() {
    _model = RegisterModel();
  }

  void handleOnChangeInput() {
    view.updateViewStatusValidation();
  }

  Future<bool> handleRegister(RegisterUserModel userRegister) async {
    _view!.updateLoading();
    try {
      _model!.user = userRegister;
      final response = await RegisterAPI.register(_model!.user);
      return (response.statusCode == 200);
    } catch (e) {
      print(e.toString());
      throw Exception('Đăng Ký không thành công');
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
