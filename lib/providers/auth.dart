import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/user.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User _currentUser;
  User _newUser;
  String _rules;
  String _aboutUs;
  String _androidVersion;
  String _iosVersion;
  String _appName;
  String _packageName;
  String _version;
  String _buildNumber;

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

  User get currentUser {
    if (_currentUser != null &&
        _currentUser.expiryDate != null &&
        _currentUser.expiryDate.isAfter(DateTime.now()) &&
        _currentUser.token != null) {
      return _currentUser;
    }
    return null;
  }

  bool get isUpdateRequired {
    return _version != _androidVersion;
  }

  Future<void> sendVerificationCode(String verificationCode) async {
    const url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'verify_mobile',
          'user': _newUser.nationalId,
          'verify_code': verificationCode,
        },
      );
      final responseData = json.decode(response.body);
      if (responseData == false) {
        throw HttpException("کد ارسالی نادرست است!");
      }
      //_currentUser = _newUser;
      //_newUser = null;
      await login(_newUser.nationalId, _newUser.mobileNo);
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
      print(responseData['tbl_user']['User_ID']);
      _newUser = User(
        id: responseData['tbl_user']['User_ID'],
        fullName: responseData['tbl_user']['Full_Name'],
        nationalId: responseData['tbl_user']['National_ID'],
        mobileNo: responseData['tbl_user']['Mobile_No'],
        userName: responseData['tbl_user']['National_ID'],
        residenceType: responseData['tbl_user']['Residence_Type'] == '1'
            ? ResidenceType.kishvand
            : ResidenceType.passenger,
        // smsNotify: responseData['tbl_user']['SMS_Notify'] == '1' ? true : false,
        // pushNotify:
        //     responseData['tbl_user']['PUSH_Notify'] == '1' ? true : false,
        token: null,
        expiryDate: null,
      );
      //_currentUser.id = responseData['tbl_user']['User_ID'];
      //_currentUser.nationalId = responseData['tbl_user']['National_ID'];
      //_currentUser.mobileNo = responseData['tbl_user']['Mobile_No'];
      //_currentUser.residenceType = responseData['tbl_user']['Residence_Type'];
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String userName, String password) async {
    const url = 'http://hamibox.ir/main/api/index.php';
    try {
      await checkConnectivity();
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
      final userToken = responseData['JWT'];
      // try {
      prefs.setString('userToken', userToken);
      // } catch (error) {
      //   print(error);
      // }
    } on SocketException catch (_) {
      throw HttpException('خطا در ارتباط با سرور!');
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
      await checkConnectivity();
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

      response = await http.post(
        url,
        body: {
          'action': 'app_info',
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      //print(responseData['data'][0]['APK_Version']);
      _androidVersion = responseData['data'][0]['APK_Version'].toString();
      _iosVersion = responseData['data'][0]['IOS_Version'].toString();
      try {
      } on SocketException catch (_) {
        throw HttpException('خطا در ارتباط با سرور!');
      } catch (error) {
        throw (error);
      }
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _appName = packageInfo.appName;
      _packageName = packageInfo.packageName;
      _version = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    } on SocketException catch (_) {
      throw HttpException('خطا در ارتباط با سرور!');
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    try {
      await checkConnectivity();
    } on SocketException catch (_) {
      throw HttpException('خطا در ارتباط با سرور!');
    } catch (error) {
      throw (error);
    }
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) {
      return false;
    }

    final userToken = prefs.getString('userToken');
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(
      _parseJwt(userToken)['exp'] * 1000,
    );

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    await _getInitialData(userToken);
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

  Future checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('hamibox.ir');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //print('connected');
      }
    } on SocketException catch (error) {
      throw error;
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
