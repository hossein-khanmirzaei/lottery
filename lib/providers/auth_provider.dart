import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

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
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
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
      print(response.body);
    } catch (error) {
      print(error);
    }
  }
}
