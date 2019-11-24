import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/user.dart';

class UserProvider with ChangeNotifier {
  final User currentUser;
  UserProvider(this.currentUser);

  ResidenceType get residenceTypeStatus {
    return currentUser.residenceType;
  }

  bool get smsNotifyStatus {
    return currentUser.smsNotify;
  }

  bool get pushNotifyStatus {
    return currentUser.pushNotify;
  }

  Future<void> changeUserPassword(
      String currentPassword, String newPassword) async {
    //print("NewPass: $newPassword");
    const url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'edit',
          'object': 'tbl_user',
          'User_ID': currentUser.id.toString(),
          'Residence_Type': (currentUser.residenceType.index + 1).toString(),
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

  Future<void> changeResidenceTypeSetting(int residenceType) async {
    const url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'edit',
          'object': 'tbl_user',
          'User_ID': currentUser.id.toString(),
          'Residence_Type': residenceType.toString(),
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
    currentUser.residenceType =
        residenceType == 1 ? ResidenceType.kishvand : ResidenceType.passenger;
    notifyListeners();
  }

  Future<void> changeSmsNotifySetting(bool smsNotify) async {
    const url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'edit',
          'object': 'tbl_user',
          'User_ID': currentUser.id.toString(),
          'Residence_Type': (currentUser.residenceType.index + 1).toString(),
          'SMS_Notify': smsNotify ? '1' : '0',
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
    currentUser.smsNotify = smsNotify;
    notifyListeners();
  }

  Future<void> changePushNotifySetting(bool pushNotify) async {
    const url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'edit',
          'object': 'tbl_user',
          'User_ID': currentUser.id.toString(),
          'Residence_Type': (currentUser.residenceType.index + 1).toString(),
          'PUSH_Notify': pushNotify ? '1' : '0',
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
    currentUser.pushNotify = pushNotify;
    notifyListeners();
  }
}
