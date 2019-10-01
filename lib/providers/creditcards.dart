import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/creditcard.dart';
import 'package:lottery/models/http_exception.dart';

class CreditCardProvider with ChangeNotifier {
  List<CreditCard> _cardList = [];

  List get cardList {
    return _cardList;
  }

  Future<void> getCardList() async {
    final url = 'http://37.156.29.144/sosanpay/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'list',
          'object': 'tbl_user_card',
        },
        headers: {
          'X-Authorization':
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1Njg2NTkxNTgsImp0aSI6IlUyWHlVRlFkSjBFTHR4N1VrNnZUc21YSzhmYUtER0wrXC8rRlZsUDVqMmJvPSIsImlzcyI6IjM3LjE1Ni4yOS4xNDQiLCJuYmYiOjE1Njg2NTkxNTgsImV4cCI6MTYwMDE5NTE1OCwic2VjdXJpdHkiOnsidXNlcm5hbWUiOiIyNzU1NTMzNTI4IiwidXNlcmlkIjoiMSIsInBhcmVudHVzZXJpZCI6IiIsInVzZXJsZXZlbGlkIjozMH19.rB2EgHNlOz2NTEFOeALzQ3R-2LXhDFADeNFJWk4A48-H_rOzoCD64o5G7WqetYXn9tTWOCieX-dkaTOmj85PRA',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      cardList.clear();
      (responseData['tbl_user_card'] as List).map((card) {
        _cardList.add(CreditCard(
          id: int.parse(card['Card_ID']),
          title: card['Card_Title'],
          status: int.parse(card['Status']),
          cardNumber: card['Card_Number'],
        ));
      }).toList();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addCard(String cardTitle, String cardNumber) async {
    final url = 'http://37.156.29.144/sosanpay/api/index.php';
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
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1Njg2NTkxNTgsImp0aSI6IlUyWHlVRlFkSjBFTHR4N1VrNnZUc21YSzhmYUtER0wrXC8rRlZsUDVqMmJvPSIsImlzcyI6IjM3LjE1Ni4yOS4xNDQiLCJuYmYiOjE1Njg2NTkxNTgsImV4cCI6MTYwMDE5NTE1OCwic2VjdXJpdHkiOnsidXNlcm5hbWUiOiIyNzU1NTMzNTI4IiwidXNlcmlkIjoiMSIsInBhcmVudHVzZXJpZCI6IiIsInVzZXJsZXZlbGlkIjozMH19.rB2EgHNlOz2NTEFOeALzQ3R-2LXhDFADeNFJWk4A48-H_rOzoCD64o5G7WqetYXn9tTWOCieX-dkaTOmj85PRA',
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
