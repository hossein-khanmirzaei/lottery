import 'package:flutter/material.dart';

class Help {
  int id;
  String title;
  String content;
  Help({
    @required this.id,
    @required this.title,
    this.content = "",
  });
}
