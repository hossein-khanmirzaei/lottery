import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Store {
  int id;
  String status;
  String logoUrl;
  String type;
  String subType;
  String unitNumber;
  String phoneNumber;
  String faxNumber;
  String mobileNumber;

  Store({
    @required this.id,
    @required this.status,
    @required this.logoUrl,
    @required this.type,
    @required this.subType,
    @required this.unitNumber,
    @required this.phoneNumber,
    @required this.faxNumber,
    @required this.mobileNumber,
  });
}
