import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/user.dart';

class UserProvider with ChangeNotifier {
  final User currentUser;
  UserProvider(this.currentUser);

  Future<void> changeUserPassword(
      String currentPassword, String newPassword) async {
    const url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'edit',
          'object': 'tbl_user',
          'User_ID': currentUser.id,
          'Residence_Type': currentUser.residenceType,
          'Password': newPassword,
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
    } catch (error) {
      throw error;
    }
  }
}
