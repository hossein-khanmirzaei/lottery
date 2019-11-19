import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/store.dart';

class StoreProvider with ChangeNotifier {
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
          'X-Authorization':
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1NzM1NzcxNTEsImp0aSI6Im9jV1wvXC9tTGJNOXFrSGpxRXBhblRkUUp4N2ZDa0RPNisyZGNtQ01Jd0NKcz0iLCJpc3MiOiJoYW1pYm94LmlyIiwibmJmIjoxNTczNTc3MTUxLCJleHAiOjE2MDUxMTMxNTEsInNlY3VyaXR5Ijp7InVzZXJuYW1lIjoiMjY0OTQwMjAzMiIsInVzZXJpZCI6IjMwIiwicGFyZW50dXNlcmlkIjoiIiwidXNlcmxldmVsaWQiOjMwfX0.ZfFk6dEu52Z8RLQDaK513rvxNFqnVgEd7Sn78LdIPPIqgGlPZzVyKwXWC2nH22AEzTRa6fcwbYZ-Z0h-XAX0fQ',
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
