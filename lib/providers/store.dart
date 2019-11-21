import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/store.dart';

class StoreProvider with ChangeNotifier {
  final String authToken;
  StoreProvider(this.authToken);

  List<Store> _storeList = [];

  List<Store> get storeList {
    return [..._storeList];
  }

  Future<void> fetchStores() async {
    final List<Store> loadedStores = [];
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'list',
          'object': 'tbl_store',
        },
        headers: {
          'X-Authorization': authToken,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);
      if (!responseData['success']) {
        throw HttpException(responseData['failureMessage']);
      }
      (responseData['tbl_store'] as List<dynamic>).forEach((s) {
        loadedStores.add(Store(
            id: int.parse(s['Store_ID']),
            status: s['Status'],
            logoUrl: s['Logo']['url'],
            name: s['Name'],
            type: s['Type'],
            subType: s['Sub_Type'],
            unitNumber: s['Unit'],
            phoneNumber: s['Tel'],
            faxNumber: s['Fax'],
            mobileNumber: s['Mobile']));
      });
      _storeList = loadedStores;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
