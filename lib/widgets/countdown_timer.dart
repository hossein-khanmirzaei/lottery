import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class MyCountdownTimer extends StatefulWidget {
  @override
  _MyCountdownTimerState createState() => _MyCountdownTimerState();
}

class _MyCountdownTimerState extends State<MyCountdownTimer> {
  int _start = 10000;
  int _current = 10000;
  //StreamSubscription sub;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  @override
  void dispose() { 
    //sub.cancel();   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            startTimer();
          },
          child: Text("start"),
        ),
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
