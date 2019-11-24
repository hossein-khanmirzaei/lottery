import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User _currentUser;
  String _rules;
  String _aboutUs;
  //  = User(
  //   id: null,
  //   fullName: null,
  //   nationalId: null,
  //   mobileNo: null,
  //   userName: null,
  //   residenceType: null,
  //   smsNotify: null,
  //   pushNotify: null,
  //   token: null,
  //   expiryDate: null,
  // );

  Timer _authTimer;

  bool get isAuth {
    return currentUser != null;
  }

  String get rules {
    return _rules;
  }

  String get aboutUs {
    return _aboutUs;
  }
  // String get token {
  //   if (_currentUser != null &&
  //       _currentUser.expiryDate != null &&
  //       _currentUser.expiryDate.isAfter(DateTime.now()) &&
  //       _currentUser.token != null) {
  //     return _currentUser.token;
  //   }
  //   return null;
  // }

  User get currentUser {
    if (_currentUser != null &&
        _currentUser.expiryDate != null &&
        _currentUser.expiryDate.isAfter(DateTime.now()) &&
        _currentUser.token != null) {
      return _currentUser;
    }
    return null;
  }

  Future<void> sendVerificationCode(String verificationCode) async {
    const url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'verify_mobile',
          'user': _currentUser.nationalId,
          'verify_code': verificationCode,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData == false) {
        throw HttpException("کد ارسالی نادرست است!");
      }
      login(_currentUser.nationalId, _currentUser.mobileNo);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String fullName, String nationalID, String mobileNo,
      String residenceType) async {
    const url = 'http://hamibox.ir/main/api/index.php';
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
      _currentUser.id = responseData['tbl_user']['User_ID'];
      _currentUser.nationalId = responseData['tbl_user']['National_ID'];
      _currentUser.mobileNo = responseData['tbl_user']['Mobile_No'];
      _currentUser.residenceType = responseData['tbl_user']['Residence_Type'];
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String userName, String password) async {
    const url = 'http://hamibox.ir/main/api/index.php';
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
      if (responseData['JWT'] == null) {
        throw HttpException('خطا در ارتباط با سرور!');
      }
      await _getInitialData(responseData['JWT']);
      notifyListeners();
      _autoLogout();
      final prefs = await SharedPreferences.getInstance();
      final userData = currentUser.toJson();
      try {
        prefs.setString('userData', jsonEncode(userData));
      } catch (error) {
        print(error);
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> _getInitialData(String authToken) async {
    const url = 'http://hamibox.ir/main/api/index.php';
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(
      _parseJwt(authToken)['exp'] * 1000,
    );
    final userId = int.parse(_parseJwt(authToken)['security']['userid']);
    try {
      var response = await http.post(
        url,
        body: {
          'action': 'view',
          'object': 'tbl_user',
          'User_ID': userId.toString(),
        },
        headers: {
          'X-Authorization': authToken,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      var responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      _currentUser = User(
        id: int.parse(responseData['tbl_user']['User_ID']),
        fullName: responseData['tbl_user']['Full_Name'],
        nationalId: responseData['tbl_user']['National_ID'],
        mobileNo: responseData['tbl_user']['Mobile_No'],
        userName: responseData['tbl_user']['User_Name'],
        residenceType: responseData['tbl_user']['Residence_Type'] == '1'
            ? ResidenceType.kishvand
            : ResidenceType.passenger,
        smsNotify: responseData['tbl_user']['SMS_Notify'] == '1' ? true : false,
        pushNotify:
            responseData['tbl_user']['PUSH_Notify'] == '1' ? true : false,
        token: authToken,
        expiryDate: expiryDate,
      );
      response = await http.post(
        url,
        body: {
          'action': 'view',
          'object': 'tbl_content',
        },
        headers: {
          'X-Authorization': authToken,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      _rules = responseData['tbl_content']['Role'];
      _aboutUs = responseData['tbl_content']['About'];
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    try {
      Map userDataMap = jsonDecode(prefs.getString('userData'));
      _currentUser = User.fromJson(userDataMap);
      print(currentUser);
    } catch (error) {
      print(error);
    }
    if (_currentUser.expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _currentUser = null;
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
    final timeToExpiry =
        _currentUser.expiryDate.difference(DateTime.now()).inSeconds;
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
