import 'package:flutter/foundation.dart';

class Transaction {
  int id;
  int status;
  String title;
  String cardNumber;
  Transaction({
    @required this.id,
    this.status = 1,
    @required this.title,
    @required this.cardNumber,
  });
}
