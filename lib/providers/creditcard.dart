import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:lottery/models/creditcard.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/user.dart';

class CreditCardProvider with ChangeNotifier {
  final User currentUser;
  CreditCardProvider(this.currentUser);

  CreditCard _currentCard;

  CreditCard get currentCard {
    return _currentCard;
  }

  List<CreditCard> _cardList = [];

  List<CreditCard> get cardList {
    return [..._cardList];
  }

  void setCurrentNews(int id) {
    _currentCard = _cardList.firstWhere((c) => c.id == id);
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
          'X-Authorization': currentUser.token,
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
          'X-Authorization': currentUser.token,
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

  Future<void> editCurrentCard(String cardTitle) async {
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'edit',
          'object': 'tbl_user_card',
          'Card_ID': _currentCard.id,
          'Status': '1',
          'Card_Title': cardTitle,
        },
        headers: {
          'X-Authorization': currentUser.token,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['success'] == false) {
        throw HttpException(responseData['failureMessage']);
      }
      _cardList.firstWhere((n) => n.id == _currentCard.id).title =
          responseData['tbl_user_card']['Card_Title'];
      _cardList.firstWhere((n) => n.id == _currentCard.id).status =
          responseData['tbl_user_card']['Status'];
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
