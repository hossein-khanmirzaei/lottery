import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/tranaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions {
    return [..._transactions];
  }

  Future<void> fetchTransactions() async {
    final List<Transaction> loadedTransactions = [];
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'list',
          'object': 'tbl_user_purchase',
        },
        headers: {
          'X-Authorization':
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1NzM1NzcxNTEsImp0aSI6Im9jV1wvXC9tTGJNOXFrSGpxRXBhblRkUUp4N2ZDa0RPNisyZGNtQ01Jd0NKcz0iLCJpc3MiOiJoYW1pYm94LmlyIiwibmJmIjoxNTczNTc3MTUxLCJleHAiOjE2MDUxMTMxNTEsInNlY3VyaXR5Ijp7InVzZXJuYW1lIjoiMjY0OTQwMjAzMiIsInVzZXJpZCI6IjMwIiwicGFyZW50dXNlcmlkIjoiIiwidXNlcmxldmVsaWQiOjMwfX0.ZfFk6dEu52Z8RLQDaK513rvxNFqnVgEd7Sn78LdIPPIqgGlPZzVyKwXWC2nH22AEzTRa6fcwbYZ-Z0h-XAX0fQ',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);
      if (!responseData['success']) {
        throw HttpException(responseData['failureMessage']);
      }
      (responseData['tbl_user_purchase'] as List<dynamic>).forEach((p) {
        loadedTransactions.add(Transaction(
          id: int.parse(p['User_Purchase_ID']),
          date: p['Transaction_Date'],
          time: p['Transaction_Time'],
          originalAmount: double.parse(p['OriginalAmount']),
          pan1: p['PAN1'],
          buyerID: int.parse(p['Buyer_ID']),
          sellerID: int.parse(p['Seller_ID']),
          mall: int.parse(p['Mall']),
          confirm: int.parse(p['Confirm']),
        ));
      });
      _transactions = loadedTransactions;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
