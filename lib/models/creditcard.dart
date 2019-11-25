import 'package:flutter/material.dart';

class CreditCard {
  int id;
  int status;
  String title;
  String cardNumber;
  CreditCard({
    @required this.id,
    this.status = 1,
    @required this.title,
    @required this.cardNumber,
  });
}