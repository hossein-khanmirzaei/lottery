import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String fullName, String nationalID, String mobileNo,
      String residenceType) async {
    const url = 'http://37.156.29.144/sosanpay/api/index.php';
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
  }
}
