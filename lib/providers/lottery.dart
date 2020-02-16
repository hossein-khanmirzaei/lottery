import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/lottery.dart';
import 'package:lottery/models/user.dart';

class LotteryProvider with ChangeNotifier {
  final User currentUser;
  LotteryProvider(this.currentUser);

  Lottery _currentLottery;

  Lottery get currentLottery {
    return _currentLottery;
  }

  List<Lottery> _lotteryList = [];

  List<Lottery> get lotteryList {
    return [..._lotteryList];
  }

  void setCurrentLottery(int id) {
    _currentLottery = _lotteryList.firstWhere((l) => l.id == id);
  }

  Future<void> fetchLotteries() async {
    final List<Lottery> loadedLotteries = [];
    final url = 'http://hamibox.ir/main/api/index.php';
    try {
      final response = await http.post(
        url,
        body: {
          'action': 'lottery_list',
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
      (responseData['data'] as List<dynamic>).forEach((l) {
        loadedLotteries.add(
          Lottery(
            id: int.parse(l['Lottery_ID']),
            status: int.parse(l['Status']),
            title: l['Title'],
            startDate: l['Start_Date'],
            endDate: l['End_Date'],
            gStartDate: DateTime.parse(l['Start_GDate']),
            gEndDate: DateTime.parse(l['End_GDate']),
            startTime: l['Start_Time'],
            endTime: l['End_Time'],
          ),
        );
      });
      _lotteryList = loadedLotteries;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
