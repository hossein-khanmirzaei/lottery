import 'package:flutter/material.dart';

class Lottery {
  int id;
  int status;
  String title;
  String startDate;
  String endDate;
  DateTime gStartDate;
  DateTime gEndDate;
  String startTime;
  String endTime;

  Lottery({
    @required this.id,
    @required this.status,
    @required this.title,
    @required this.startDate,
    @required this.endDate,
    @required this.gStartDate,
    @required this.gEndDate,
    @required this.startTime,
    @required this.endTime,
  });
}
