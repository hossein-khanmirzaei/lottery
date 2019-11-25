import 'package:flutter/material.dart';

class News {
  int id;
  String status;
  String title;
  String date;
  String time;
  String note;

  News({
    @required this.id,
    @required this.status,
    @required this.title,
    @required this.date,
    @required this.time,
    this.note = "",
  });
}
