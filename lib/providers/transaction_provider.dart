import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/http_exception.dart';

class TransactionProvider with ChangeNotifier {
  // String _totalCredit;
  // String _totalPayment;

  // String get totalCredit {
  //   return _totalCredit;
  // }

  // String get totalPayment {
  //   return _totalPayment;
  // }
  var _transactionList;

  List get transactionList {
    return _transactionList;
  }

  Future<void> getTransactionList() async {
    final url = 'http://37.156.29.144/sosanpay/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'list',
          'object': 'tbl_user_purchase',
        },
        headers: {
          'X-Authorization':
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1Njg2NTkxNTgsImp0aSI6IlUyWHlVRlFkSjBFTHR4N1VrNnZUc21YSzhmYUtER0wrXC8rRlZsUDVqMmJvPSIsImlzcyI6IjM3LjE1Ni4yOS4xNDQiLCJuYmYiOjE1Njg2NTkxNTgsImV4cCI6MTYwMDE5NTE1OCwic2VjdXJpdHkiOnsidXNlcm5hbWUiOiIyNzU1NTMzNTI4IiwidXNlcmlkIjoiMSIsInBhcmVudHVzZXJpZCI6IiIsInVzZXJsZXZlbGlkIjozMH19.rB2EgHNlOz2NTEFOeALzQ3R-2LXhDFADeNFJWk4A48-H_rOzoCD64o5G7WqetYXn9tTWOCieX-dkaTOmj85PRA',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      _transactionList = responseData['tbl_user_purchase'];
      print(_transactionList);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
