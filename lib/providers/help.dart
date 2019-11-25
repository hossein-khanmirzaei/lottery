import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/help.dart';
import 'package:lottery/models/user.dart';

class HelpProvider with ChangeNotifier {
  final User currentUser;
  HelpProvider(this.currentUser);

  Help _currentHelpContent;

  Help get currentHelpContent {
    return _currentHelpContent;
  }

  List<Help> _helpList = [];

  List<Help> get helpList {
    return [..._helpList];
  }

  void setCurrentHelp(int id) {
    _currentHelpContent = _helpList.firstWhere((h) => h.id == id);
  }

  Future<void> fetchHelpList() async {
    final List<Help> loadedHelp = [];
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'list',
          'object': 'tbl_help',
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
      (responseData['tbl_help'] as List<dynamic>).forEach((n) {
        loadedHelp.add(Help(
          id: int.parse(n['Help_ID']),
          title: n['Title'],
        ));
      });
      _helpList = loadedHelp;
      // _newsList = loadedNews
      //   ..sort((a, b) => (b.date + ' ' + b.time)
      //       .toLowerCase()
      //       .compareTo((a.date + ' ' + a.time).toLowerCase()));
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchCurrentHelpContent() async {
    //String newsDetail = '';
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'view',
          'object': 'tbl_help',
          'Help_ID': _currentHelpContent.id.toString(),
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
      _helpList.firstWhere((h) => h.id == _currentHelpContent.id).content =
          responseData['tbl_help']['Content'];
      print(responseData['tbl_help']['Content']);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
