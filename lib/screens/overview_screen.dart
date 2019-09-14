import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  final double _totalCredit = 0;
  final double _totalPayment = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200.0),
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
              ),
            ],
            flexibleSpace: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'مجموع خرید',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontFamily: 'IRANSans'),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        _totalPayment.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'IRANSans',
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ButtonTheme(
                        minWidth: 120.0,
                        child: OutlineButton(
                          child: Text(
                            "لیست کارت ها",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'IRANSans',
                            ),
                          ),
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white, //Color of the border
                            style: BorderStyle.solid, //Style of the border
                            width: 0.8, //width of the border
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'مجموع امتیاز',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontFamily: 'IRANSans'),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        _totalCredit.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'IRANSans',
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ButtonTheme(
                        minWidth: 120.0,
                        child: RaisedButton(
                          child: Text(
                            "افزودن کارت",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'IRANSans',
                            ),
                          ),
                          color: Colors.green,
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Center(),
      ),
    );
  }
}