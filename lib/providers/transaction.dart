import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/tranaction.dart';
import 'package:lottery/models/user.dart';

class TransactionProvider with ChangeNotifier {
  final User currentUser;

  String _totalCredit;
  String _totalPayment;

  TransactionProvider(this.currentUser);

  Transaction _currentTransaction;

  Transaction get currentTransaction {
    return _currentTransaction;
  }

  List<Transaction> _transactions = [];

  List<Transaction> get transactions {
    return [..._transactions];
  }

  String get totalCredit {
    return _totalCredit;
  }

  String get totalPayment {
    return _totalPayment;
  }

  void setCurrentTransaction(int id) {
    _currentTransaction = _transactions.firstWhere((t) => t.id == id);
  }

  Future<void> fetchTransactions() async {
    final List<Transaction> loadedTransactions = [];
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'transaction_list',
          'user': currentUser.id.toString(),
        },
        headers: {
          'X-Authorization': currentUser.token,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);
      if (!responseData['success']) {
        throw HttpException(responseData['failureMessage']);
      }
      (responseData['data'] as List<dynamic>).forEach((p) {
        loadedTransactions.add(Transaction(
          id: int.parse(p['User_Purchase_ID']),
          name: p['Name'],
          traceDate: p['STraceDt'],
          date: p['Transaction_Date'],
          time: p['Transaction_Time'],
          originalAmount: double.parse(p['OriginalAmount']),
          pan1: p['PAN1'],
          buyerName: p['Buyer Name'],
          sellerName: p['Seller Name'],
          mallName: p['MerchantName'],
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

  // Future<void> fetchTransactions() async {
  //   final List<Transaction> loadedTransactions = [];
  //   final url = 'http://hamibox.ir/main/api/index.php';
  //   try {
  //     final response = await http.post(
  //       url,
  //       body: {
  //         'action': 'list',
  //         'object': 'tbl_user_purchase',
  //       },
  //       headers: {
  //         'X-Authorization': currentUser.token,
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //       },
  //     );
  //     final responseData = json.decode(response.body);
  //     if (!responseData['success']) {
  //       throw HttpException(responseData['failureMessage']);
  //     }
  //     (responseData['tbl_user_purchase'] as List<dynamic>).forEach((p) {
  //       loadedTransactions.add(Transaction(
  //         id: int.parse(p['User_Purchase_ID']),
  //         date: p['Transaction_Date'],
  //         time: p['Transaction_Time'],
  //         originalAmount: double.parse(p['OriginalAmount']),
  //         pan1: p['PAN1'],
  //         buyerID: int.parse(p['Buyer_ID']),
  //         sellerID: int.parse(p['Seller_ID']),
  //         mall: int.parse(p['Mall']),
  //         confirm: int.parse(p['Confirm']),
  //       ));
  //     });
  //     _transactions = loadedTransactions;
  //     notifyListeners();
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  Future<void> getTotalPayment() async {
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'user_total_payment',
          'user': currentUser.userName,
        },
        headers: {
          'X-Authorization': currentUser.token,
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

  Future<void> getTotalCredit() async {
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'user_total_credit',
          'user': currentUser.userName,
        },
        headers: {
          'X-Authorization': currentUser.token,
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
