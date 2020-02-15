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
  int _start;
  int _current;
  StreamSubscription<CountdownTimer> sub;

  void startTimer() {
    CountdownTimer countDownTimer = CountdownTimer(
      Duration(seconds: _start),
      Duration(seconds: 1),
    );

    sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      sub.cancel();
    });
  }

  @override
  void initState() {
    _start = widget.endDate.difference(DateTime.now()).inSeconds;
    _current = _start;
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (_current < _start && _current > 0) sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          Duration(seconds: _current)
              .toString()
              .split('.')
              .first
              .padLeft(8, "0"),
          style: TextStyle(fontSize: 24.0),
        ),
      ],
    );
  }
}
