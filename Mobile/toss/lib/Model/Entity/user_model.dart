import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class UserModel with ChangeNotifier {
  String? username;
  DateTime? dateofbirth;
  String? identityCard;
  String? email;
  String? phoneNumber;
  int? gender;
  String? location;
  int? cwtId;
  String? fullname;
  String? token;
  String? lastActive;
  String? photoUrl;

  UserModel({
    required this.username,
    required this.dateofbirth,
    required this.identityCard,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.location,
    required this.cwtId,
    required this.fullname,
    required this.token,
    required this.lastActive,
    required this.photoUrl,
  });

  UserModel.empty() {
    username = '';
    dateofbirth = DateTime.now();
    identityCard = '';
    email = '';
    phoneNumber = '';
    gender = 1;
    location = '';
    cwtId = 0;
    fullname = '';
    token = '';
    lastActive = '';
    photoUrl = '';
  }

  UserModel copyWith({
    String? username,
    DateTime? dateofbirth,
    String? identityCard,
    String? email,
    String? phoneNumber,
    int? gender,
    String? location,
    int? cwtId,
    String? fullname,
    String? token,
    String? lastActive,
    String? photoUrl,
  }) {
    return UserModel(
      username: username ?? this.username,
      dateofbirth: dateofbirth ?? this.dateofbirth,
      identityCard: identityCard ?? this.identityCard,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      cwtId: cwtId ?? this.cwtId,
      fullname: fullname ?? this.fullname,
      token: token ?? this.token,
      lastActive: lastActive ?? this.lastActive,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'username': username});
    result.addAll({'dateofbirth': dateofbirth});
    result.addAll({'identityCard': identityCard});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'gender': gender});
    result.addAll({'location': location});
    result.addAll({'cwtId': cwtId});
    result.addAll({'fullname': fullname});
    result.addAll({'token': token});
    result.addAll({'lastActive': lastActive});
    result.addAll({'photoUrl': photoUrl});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    DateTime dbo = DateFormat('dd/MM/yyyy').parse(map['dateofbirth'].toString().substring(5, 7)+'/'+map['dateofbirth'].toString().substring(8, 10)+'/'+map['dateofbirth'].toString().substring(0, 4));
    return UserModel(
      username: map['username'] ?? '',
      dateofbirth: map['dateofbirth']!='' ? dbo : DateTime.now(),
      identityCard: map['identityCard'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      gender: map['gender'] ? 1 : 0,
      location: map['location'] ?? '',
      cwtId: map['cwtId']?.toInt() ?? 0,
      fullname: map['fullname'] ?? '',
      token: map['token'] ?? '',
      lastActive: map['lastActive'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(username: $username, dateofbirth: $dateofbirth, identityCard: $identityCard, email: $email, phoneNumber: $phoneNumber, gender: $gender, location: $location, cwtId: $cwtId, fullname: $fullname, token: $token, lastActive: $lastActive, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.username == username &&
        other.dateofbirth == dateofbirth &&
        other.identityCard == identityCard &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.gender == gender &&
        other.location == location &&
        other.cwtId == cwtId &&
        other.fullname == fullname &&
        other.token == token &&
        other.lastActive == lastActive &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return username.hashCode ^
    dateofbirth.hashCode ^
    identityCard.hashCode ^
    email.hashCode ^
    phoneNumber.hashCode ^
    gender.hashCode ^
    location.hashCode ^
    cwtId.hashCode ^
    fullname.hashCode ^
    token.hashCode ^
    lastActive.hashCode ^
    photoUrl.hashCode;
  }
}
