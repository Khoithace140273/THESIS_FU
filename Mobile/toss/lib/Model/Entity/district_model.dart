import 'dart:convert';

List<DistrictModel> districtModelFromJson(String str) => List<DistrictModel>.from(json.decode(str).map((x) => DistrictModel.fromJson(x)));

class DistrictModel {
  int? districtId;
  int? provinceId;
  String? name;
  String? type;

  DistrictModel.empty() {
    districtId = 0;
    provinceId = 0;
    name = '';
    type = '';
  }

  DistrictModel(
      {required this.districtId,
      required this.provinceId,
      required this.name,
      required this.type});


  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
    districtId: json["districtId"],
    provinceId: json["provinceId"],
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "districtId": districtId,
    "provinceId": provinceId,
    "name": name,
    "type": type,
  };
}
