import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/creditcard.dart';
import 'package:lottery/models/http_exception.dart';

class CreditCardProvider with ChangeNotifier {
  List<CreditCard> _cardList = [];

  List<CreditCard> get cardList {
    return [..._cardList];
  }

  Future<void> getCardList() async {
    final List<CreditCard> loadedCreditcards = [];
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'list',
          'object': 'tbl_user_card',
        },
        headers: {
          'X-Authorization':
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1NzM1NzcxNTEsImp0aSI6Im9jV1wvXC9tTGJNOXFrSGpxRXBhblRkUUp4N2ZDa0RPNisyZGNtQ01Jd0NKcz0iLCJpc3MiOiJoYW1pYm94LmlyIiwibmJmIjoxNTczNTc3MTUxLCJleHAiOjE2MDUxMTMxNTEsInNlY3VyaXR5Ijp7InVzZXJuYW1lIjoiMjY0OTQwMjAzMiIsInVzZXJpZCI6IjMwIiwicGFyZW50dXNlcmlkIjoiIiwidXNlcmxldmVsaWQiOjMwfX0.ZfFk6dEu52Z8RLQDaK513rvxNFqnVgEd7Sn78LdIPPIqgGlPZzVyKwXWC2nH22AEzTRa6fcwbYZ-Z0h-XAX0fQ',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      (responseData['tbl_user_card'] as List).map((card) {
        loadedCreditcards.add(CreditCard(
          id: int.parse(card['Card_ID']),
          title: card['Card_Title'],
          status: int.parse(card['Status']),
          cardNumber: card['Card_Number'],
        ));
      }).toList();
      _cardList = loadedCreditcards;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addCard(String cardTitle, String cardNumber) async {
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'add',
          'object': 'tbl_user_card',
          'Status': '1',
          'Card_Title': cardTitle,
          'Card_Number': cardNumber,
        },
        headers: {
          'X-Authorization':
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1NzM1NzcxNTEsImp0aSI6Im9jV1wvXC9tTGJNOXFrSGpxRXBhblRkUUp4N2ZDa0RPNisyZGNtQ01Jd0NKcz0iLCJpc3MiOiJoYW1pYm94LmlyIiwibmJmIjoxNTczNTc3MTUxLCJleHAiOjE2MDUxMTMxNTEsInNlY3VyaXR5Ijp7InVzZXJuYW1lIjoiMjY0OTQwMjAzMiIsInVzZXJpZCI6IjMwIiwicGFyZW50dXNlcmlkIjoiIiwidXNlcmxldmVsaWQiOjMwfX0.ZfFk6dEu52Z8RLQDaK513rvxNFqnVgEd7Sn78LdIPPIqgGlPZzVyKwXWC2nH22AEzTRa6fcwbYZ-Z0h-XAX0fQ',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      _cardList.add(CreditCard(
        id: responseData['tbl_user_card']['Card_ID'],
        title: responseData['tbl_user_card']['Card_Title'],
        status: responseData['tbl_user_card']['Status'],
        cardNumber: responseData['tbl_user_card']['Card_Number'],
      ));
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
