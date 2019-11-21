import 'package:flutter/foundation.dart';

class User {
  int id;
  String fullName;
  String nationalId;
  String mobileNo;
  String userName;
  int residenceType;
  int smsNotify;
  int pushNotify;
  String token;
  User({
    @required this.id,
    @required this.fullName,
    @required this.nationalId,
    @required this.mobileNo,
    @required this.userName,
    @required this.residenceType,
    this.smsNotify = 1,
    this.pushNotify = 1,
    this.token = "",
  });
}