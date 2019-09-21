import 'package:flutter/foundation.dart';

class Card {
  int id;
  int status;
  String title;
  String cardNumber;
  Card({
    @required this.id,
    this.status = 1,
    @required this.title,
    @required this.cardNumber,
  });
}