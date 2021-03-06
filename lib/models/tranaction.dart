import 'package:flutter/material.dart';

class Transaction {
  int id;
  String name;
  String traceDate;
  String date;
  String time;
  double originalAmount;
  String pan1;
  String buyerName;
  String sellerName;
  String mallName;
  int confirm;

  Transaction({
    @required this.id,
    @required this.name,
    @required this.traceDate,
    @required this.date,
    @required this.time,
    @required this.originalAmount,
    @required this.pan1,
    @required this.buyerName,
    @required this.sellerName,
    @required this.mallName,
    @required this.confirm,
  });

// class Transaction {
//   int id;
//   String name;
//   String traceDate;
//   String date;
//   String time;
//   double originalAmount;
//   String pan1;
//   int buyerID;
//   int sellerID;
//   int mall;
//   int confirm;

//   Transaction({
//     @required this.id,
//     @required this.name,
//     @required this.traceDate,
//     @required this.date,
//     @required this.time,
//     @required this.originalAmount,
//     @required this.pan1,
//     @required this.buyerID,
//     @required this.sellerID,
//     @required this.mall,
//     @required this.confirm,
//   });
}
