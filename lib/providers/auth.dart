import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  int _userId;
  String _userNationalCode;
  String _userMobileNo;
  int _userResidenceType;
  Timer _authTimer;

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

  String get userNationalCode {
    return _userNationalCode;
  }

  String get userMobileNo {
    return _userMobileNo;
  }

  int get userResidenceType {
    return _userResidenceType;
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
      _userNationalCode = responseData['tbl_user']['National_ID'];
      _userMobileNo = responseData['tbl_user']['Mobile_No'];
      _userResidenceType = responseData['tbl_user']['Residence_Type'];
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
      _expiryDate = DateTime.fromMillisecondsSinceEpoch(
        _parseJwt(_token)['exp'] * 1000,
      );
      _userId = int.parse(_parseJwt(_token)['security']['userid']);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> sendVerificationCode(
      String nationalID, String mobileNo, String verificationCode) async {
    const url = 'http://37.156.29.144/sosanpay/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'verify_mobile',
          'user': nationalID,
          'verify_code': verificationCode,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData == false) {
        throw HttpException("کد ارسالی نادرست است!");
      }
      login(nationalID, mobileNo);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
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
    //print(payloadMap);
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
