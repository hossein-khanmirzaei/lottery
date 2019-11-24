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
}
