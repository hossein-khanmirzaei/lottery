import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: Row(
                children: <Widget>[
                  Text('1'),
                  Text('2'),
                ],
              ),
            ),
            Center(
              child: Row(
                children: <Widget>[
                  Text('3'),
                  Text('4'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
