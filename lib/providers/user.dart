import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/user.dart';

class UserProvider with ChangeNotifier {
  final User _currentUser = null;

  User get currentUser {
    return _currentUser;
  }
}
