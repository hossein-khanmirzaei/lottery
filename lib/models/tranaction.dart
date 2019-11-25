import 'package:flutter/material.dart';

class Transaction {
  int id;
  String date;
  String time;
  double originalAmount;
  String pan1;
  int buyerID;
  int sellerID;
  int mall;
  int confirm;

  Transaction({
    @required this.id,
    @required this.date,
    @required this.time,
    @required this.originalAmount,
    @required this.pan1,
    @required this.buyerID,
    @required this.sellerID,
    @required this.mall,
    @required this.confirm,
  });
}
