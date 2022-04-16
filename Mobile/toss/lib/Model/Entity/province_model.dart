import 'dart:convert';

List<ProvinceModel> provinceModelFromJson(String str) => List<ProvinceModel>.from(json.decode(str).map((x) => ProvinceModel.fromJson(x)));

class ProvinceModel {
  int? provinceId;
  String? name;
  String? slug;
  String? type;

  ProvinceModel.empty() {
    provinceId = 0;
    name = '';
    slug = '';
    type = '';
  }

  ProvinceModel(
      {required this.provinceId,
      required this.name,
      required this.slug,
      required this.type});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
    provinceId: json["provinceId"] == null ? null : json["provinceId"],
    name: json["name"] == null ? null : json["name"],
    slug: json["slug"] == null ? null : json["slug"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "provinceId": provinceId == null ? null : provinceId,
    "name": name == null ? null : name,
    "slug": slug == null ? null : slug,
    "type": type == null ? null : type,
  };
}
