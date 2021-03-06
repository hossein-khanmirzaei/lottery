import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/store.dart';
import 'package:lottery/models/user.dart';

class StoreProvider with ChangeNotifier {
  final User currentUser;
  StoreProvider(this.currentUser);

  Store _currentStore;

  Store get currentStore {
    return _currentStore;
  }

  List<Store> _storeList = [];

  List<Store> get storeList {
    return [..._storeList];
  }

  void setCurrentStore(int id) {
    _currentStore = _storeList.firstWhere((s) => s.id == id);
  }

  Future<void> fetchStores() async {
    final List<Store> loadedStores = [];
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'store_list',
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
      (responseData['data'] as List<dynamic>).forEach((s) {
        loadedStores.add(
          Store(
            id: int.parse(s['Store_ID']),
            status: s['Status'],
            logoUrl: s['Logo'],
            name: s['Store_Name'],
            type: s['Store_Category'],
            subType: s['Store_Sub_Category'],
            unitNumber: s['Unit'],
            phoneNumber: s['Tel'],
            faxNumber: s['Fax'],
            mobileNumber: s['Mobile'],
            address: s['Address'],
          ),
        );
      });
      _storeList = loadedStores;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
