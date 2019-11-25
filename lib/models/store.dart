import 'package:flutter/material.dart';

class Store {
  int id;
  String status;
  String logoUrl;
  String name;
  String type;
  String subType;
  String unitNumber;
  String phoneNumber;
  String faxNumber;
  String mobileNumber;
  String address;

  Store({
    @required this.id,
    @required this.status,
    @required this.logoUrl,
    @required this.name,
    @required this.type,
    @required this.subType,
    @required this.unitNumber,
    @required this.phoneNumber,
    @required this.faxNumber,
    @required this.mobileNumber,
    @required this.address,
  });
}
