import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  int _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  int get userId {
    return _userId;
  }

  Future<void> signup(String fullName, String nationalID, String mobileNo,
      String residenceType) async {
    const url = 'http://37.156.29.144/sosanpay/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'add',
          'object': 'tbl_user',
          'Full_Name': fullName,
          'National_ID': nationalID,
          'Mobile_No': mobileNo,
          'Residence_Type': residenceType
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      _userId = responseData['tbl_user']['User_ID'];
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String userName, String password) async {
    const url = 'http://37.156.29.144/sosanpay/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'login',
          'username': userName,
          'password': password,
        },
      );
      if (response.statusCode == 401) {
        throw HttpException('نام کاربری یا کلمه عبور صحیح نمی باشد!');
      }
      final responseData = json.decode(response.body);
      _token = responseData['JWT'];
      _expiryDate = new DateTime.fromMillisecondsSinceEpoch(
        _parseJwt(_token)['exp'] * 1000,
      );
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
