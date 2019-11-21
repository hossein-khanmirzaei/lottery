import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/http_exception.dart';

class OverviewProvider with ChangeNotifier {
  final String authToken;
  OverviewProvider(this.authToken);

  String _totalCredit;
  String _totalPayment;

  String get totalCredit {
    return _totalCredit;
  }

  String get totalPayment {
    return _totalPayment;
  }

  Future<void> getTotalPayment(String username) async {
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'user_total_payment',
          'user': username,
        },
        headers: {
          'X-Authorization': authToken,            
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      _totalPayment = responseData['data']['Total_Amount'].toString();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> getTotalCredit(String username) async {
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'user_total_credit',
          'user': username,
        },
        headers: {
          'X-Authorization': authToken,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);
      //print(responseData);
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      _totalCredit = responseData['data']['Total_Credit'].toString();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
