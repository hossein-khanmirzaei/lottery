import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/http_exception.dart';

class OverviewProvider with ChangeNotifier {
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
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      notifyListeners();
    } catch (error) {
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
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
