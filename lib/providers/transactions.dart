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
