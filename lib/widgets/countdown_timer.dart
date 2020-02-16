import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class MyCountdownTimer extends StatefulWidget {
  final DateTime endDate;
  MyCountdownTimer(this.endDate);

  @override
  _MyCountdownTimerState createState() => _MyCountdownTimerState();
}

class _MyCountdownTimerState extends State<MyCountdownTimer> {
  Duration _start;
  Duration _current;
  StreamSubscription<CountdownTimer> sub;

  void startTimer() {
    CountdownTimer countDownTimer = CountdownTimer(
      _start,
      Duration(seconds: 1),
    );

    sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed;
      });
    });

    sub.onDone(() {
      sub.cancel();
    });
  }

  @override
  void initState() {
    //print(widget.endDate);
    _start = widget.endDate.difference(DateTime.now()); //.inSeconds;
    if (!_start.isNegative) {
      _current = _start;
      startTimer();
    } else
      _current = Duration(seconds: 0);
    super.initState();
  }

  @override
  void dispose() {
    if (_current < _start && _current.inSeconds > 0) sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int _currentDays = _current.inDays;
    final int _currentHours = (_current - Duration(days: _currentDays)).inHours;
    final int _currentMinutes = (_current -
            Duration(days: _currentDays) -
            Duration(hours: _currentHours))
        .inMinutes;
    final int _currentSeconds = (_current -
            Duration(days: _currentDays) -
            Duration(hours: _currentHours) -
            Duration(minutes: _currentMinutes))
        .inSeconds;
    return Column(
      children: <Widget>[
        Text(
          (_currentDays > 0 ? _currentDays.toString() + " روز و " : "") +
              ((_currentDays > 0 || _currentHours > 0)
                  ? _currentHours.toString() + " ساعت و "
                  : "") +
              ((_currentDays > 0 || _currentHours > 0 || _currentMinutes > 0)
                  ? _currentMinutes.toString() + " دقیقه و "
                  : "") +
              ((_currentDays > 0 ||
                      _currentHours > 0 ||
                      _currentMinutes > 0 ||
                      _currentSeconds > 0)
                  ? _currentSeconds.toString() + " ثانیه"
                  : "به اتمام رسیده است"),
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
