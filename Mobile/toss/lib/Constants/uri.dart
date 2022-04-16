// ignore_for_file: constant_identifier_names

class URI {
  URI._();

  //192.168.22.114
  static const String BASE_URI = 'http://192.168.22.114:5000/';

  static const String USER_LOGIN = 'api/v1/Account/Login';
  static const String USER_REGISTER = 'api/v1/Account/RegisterPatient';

  static const String GET_PROVINCES = 'api/v1/Support/GetAllProvince';
  static const String GET_DISTRICTS_BY_PROVINCE =
      'api/v1/Support/GetAllDistrictbyProvince?id=';
  static const String GET_CWTS_BY_DISTRICT =
      'api/v1/Support/GetAllCWTbyDistrict?id=';
}
