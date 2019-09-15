import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OverviewProvider with ChangeNotifier {
  String _totalCredit;
  String _totalPayment;

  String get totalCredit {
    return _totalCredit;
  }

  String get totalPayment {
    return _totalPayment;
  }

  Future<void> getTotalPayment(String username) async {
    final url = 'http://37.156.29.144/sosanpay/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'user_total_payment',
          'user': username,
        },
      );
      final responseData = json.decode(response.body);
      // if (responseData['success'] == false) {
      //   throw HttpException(responseData['failureMessage']);
      // }
      _totalPayment = responseData['Total_Amount'].toString();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> getTotalCredit(String username) async {
    final url = 'http://37.156.29.144/sosanpay/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'user_total_credit',
          'user': username,
        },
      );
      final responseData = json.decode(response.body);
      print(responseData);
      // if (responseData['success'] == false) {
      //   throw HttpException(responseData['failureMessage']);
      // }
      _totalCredit = responseData['Total_Credit'].toString();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
