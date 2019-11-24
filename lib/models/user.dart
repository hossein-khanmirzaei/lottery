import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum ResidenceType { kishvand, passenger }

class User {
  int id;
  String fullName;
  String nationalId;
  String mobileNo;
  String userName;
  ResidenceType residenceType;
  bool smsNotify;
  bool pushNotify;
  String token;
  DateTime expiryDate;
  User({
    @required this.id,
    @required this.fullName,
    @required this.nationalId,
    @required this.mobileNo,
    @required this.userName,
    @required this.residenceType,
    @required this.token,
    @required this.expiryDate,
    this.smsNotify = true,
    this.pushNotify = true,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fullName = json['fullName'],
        nationalId = json['nationalId'],
        mobileNo = json['mobileNo'],
        userName = json['userName'],
        residenceType = json['residenceType'] == 1
            ? ResidenceType.kishvand
            : ResidenceType.passenger,
        token = json['token'],
        expiryDate = DateTime.parse(json['expiryDate']),
        smsNotify = json['smsNotify'],
        pushNotify = json['pushNotify'];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'fullName': this.fullName,
        'nationalId': this.nationalId,
        'mobileNo': this.mobileNo,
        'userName': this.userName,
        'residenceType': this.residenceType == ResidenceType.kishvand ? 1 : 2,
        'token': this.token,
        'expiryDate': this.expiryDate.toIso8601String(),
        'smsNotify': this.smsNotify,
        'pushNotify': this.pushNotify,
      };

  // @override
  // String toString() {
  //   return '{"id": ${this.id}, "fullName": "${this.fullName}", "nationalId": "${this.nationalId}", "mobileNo": "${this.mobileNo}", "userName": "${this.userName}", "residenceType": ${this.residenceType == ResidenceType.kishvand ? 1 : 0}, "token": "${this.token}", "expiryDate": "${this.expiryDate.toIso8601String()}", "smsNotify": ${this.smsNotify}, "pushNotify": ${this.pushNotify}}';
  // }
}
