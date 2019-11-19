import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/news.dart';

class NewsProvider with ChangeNotifier {
  News _currentNews;

  News get currentNews {
    return _currentNews;
  }

  List<News> _newsList = [];

  List<News> get newsList {
    return [..._newsList];
  }

  void setCurrentNews(int id) {
    _currentNews = _newsList.firstWhere((n) => n.id == id);
  }

  Future<void> fetchNews() async {
    final List<News> loadedNews = [];
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'list',
          'object': 'tbl_news',
        },
        headers: {
          'X-Authorization':
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1NzM1NzcxNTEsImp0aSI6Im9jV1wvXC9tTGJNOXFrSGpxRXBhblRkUUp4N2ZDa0RPNisyZGNtQ01Jd0NKcz0iLCJpc3MiOiJoYW1pYm94LmlyIiwibmJmIjoxNTczNTc3MTUxLCJleHAiOjE2MDUxMTMxNTEsInNlY3VyaXR5Ijp7InVzZXJuYW1lIjoiMjY0OTQwMjAzMiIsInVzZXJpZCI6IjMwIiwicGFyZW50dXNlcmlkIjoiIiwidXNlcmxldmVsaWQiOjMwfX0.ZfFk6dEu52Z8RLQDaK513rvxNFqnVgEd7Sn78LdIPPIqgGlPZzVyKwXWC2nH22AEzTRa6fcwbYZ-Z0h-XAX0fQ',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);
      if (!responseData['success']) {
        throw HttpException(responseData['failureMessage']);
      }
      (responseData['tbl_news'] as List<dynamic>).forEach((n) {
        loadedNews.add(News(
          id: int.parse(n['News_ID']),
          status: n['Status'],
          title: n['Title'],
          date: n['Date'],
          time: n['Time'],
        ));
      });
      _newsList = loadedNews
        ..sort((a, b) => (b.date + ' ' + b.time)
            .toLowerCase()
            .compareTo((a.date + ' ' + a.time).toLowerCase()));
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchCurrentNewsDetail() async {
    //String newsDetail = '';
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'view',
          'object': 'tbl_news',
          'News_ID': _currentNews.id.toString()
        },
        headers: {
          'X-Authorization':
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1NzM1NzcxNTEsImp0aSI6Im9jV1wvXC9tTGJNOXFrSGpxRXBhblRkUUp4N2ZDa0RPNisyZGNtQ01Jd0NKcz0iLCJpc3MiOiJoYW1pYm94LmlyIiwibmJmIjoxNTczNTc3MTUxLCJleHAiOjE2MDUxMTMxNTEsInNlY3VyaXR5Ijp7InVzZXJuYW1lIjoiMjY0OTQwMjAzMiIsInVzZXJpZCI6IjMwIiwicGFyZW50dXNlcmlkIjoiIiwidXNlcmxldmVsaWQiOjMwfX0.ZfFk6dEu52Z8RLQDaK513rvxNFqnVgEd7Sn78LdIPPIqgGlPZzVyKwXWC2nH22AEzTRa6fcwbYZ-Z0h-XAX0fQ',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);
      if (!responseData['success']) {
        throw HttpException(responseData['failureMessage']);
      }
      _newsList.firstWhere((n) => n.id == _currentNews.id).note =
          responseData['tbl_news']['Note'];
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
