import 'dart:convert';

List<CWTModel> cwtModelFromJson(String str) => List<CWTModel>.from(json.decode(str).map((x) => CWTModel.fromJson(x)));

class CWTModel {
  int? cwtId;
  int? districtId;
  String? name;
  String? type;

  CWTModel.empty() {
    cwtId = 0;
    districtId = 0;
    name = '';
    type = '';
  }

  CWTModel(
      {required this.cwtId,
      required this.districtId,
      required this.name,
      required this.type});

  factory CWTModel.fromJson(Map<String, dynamic> json) => CWTModel(
    cwtId: json["cwtId"],
    districtId: json["districtId"],
    name: json["name"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "cwtId": cwtId,
    "districtId": districtId,
    "name": name,
    "type": type,
  };
}
