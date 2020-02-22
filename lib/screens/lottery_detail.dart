import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottery/models/lottery.dart';
import 'package:lottery/widgets/countdown_timer.dart';
import 'package:lottery/widgets/rec.dart';
import 'package:ota_update/ota_update.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/lottery.dart';
//import 'package:url_launcher/url_launcher.dart';

class LotteryDetailScreen extends StatefulWidget {
  static const routeName = '/lotteryDetail';
  @override
  _LotteryDetailScreenState createState() => _LotteryDetailScreenState();
}

class _LotteryDetailScreenState extends State<LotteryDetailScreen> {
  var _isLoading = false;
  OtaEvent _currentEvent;
  bool _check = false;
  Lottery _currentLottery;

  void _getcurrentLotteryDetail() {
    setState(() {
      _isLoading = true;
    });
    _currentLottery =
        Provider.of<LotteryProvider>(context, listen: false).currentLottery;
    setState(() {
      _isLoading = false;
    });
  }

  // _launchURL() async {
  //   const url = 'http://hamibox.ir/main/app/download.html';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('خطا!'),
        content: Text(
          message,
          textAlign: TextAlign.justify,
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Theme.of(context).accentColor,
            color: Theme.of(context).primaryColor,
            child: Text('بستن'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _showCircularProgressIndicator(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('خطا!'),
        content: CircularProgressIndicator(
          value: double.parse(_currentEvent.value),
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Theme.of(context).accentColor,
            color: Theme.of(context).primaryColor,
            child: Text('بستن'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> tryOtaUpdate() async {
    try {
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES
      OtaUpdate()
          .execute('https://silvana-tnk.com/app.apk',
              destinationFilename: 'app.apk')
          .listen(
        (OtaEvent event) {
          setState(() => _currentEvent = event);
          if (_currentEvent.value != null && _check) {
            _showCircularProgressIndicator('');
            _check = true;
          }
        },
      );
    } catch (e) {
      _showErrorDialog('خطا در به-روز رسانی!');
    }
  }

  @override
  void initState() {
    _getcurrentLotteryDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            color: Colors.white.withOpacity(0.5),
            child: Column(
              children: <Widget>[
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 20, top: 10, bottom: 10),
                          child: Icon(
                            FontAwesomeIcons.trophy,
                            color: Colors.deepPurple,
                            size: 36,
                          ),
                        ),
                        Text(
                          'جزئیات قرعه کشی',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      MyRec(width: MediaQuery.of(context).size.width),
                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 45, horizontal: 25),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                  const Radius.circular(16.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      _currentLottery.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(179, 55, 209, 1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Divider(
                                      color: Color.fromRGBO(179, 55, 209, 1),
                                      thickness: 2,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('تاریخ شروع'),
                                              Text(_currentLottery.startDate),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Divider(
                                              color: Colors.grey.shade300,
                                              thickness: 2,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('تاریخ خاتمه'),
                                              Text(_currentLottery.endDate),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Divider(
                                              color: Colors.grey.shade300,
                                              thickness: 2,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('ساعت شروع'),
                                              Text(_currentLottery.startTime),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Divider(
                                              color: Colors.grey.shade300,
                                              thickness: 2,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('ساعت خاتمه'),
                                              Text(_currentLottery.endTime),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Divider(
                                              color: Colors.grey.shade300,
                                              thickness: 2,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              MyCountdownTimer(
                                                _currentLottery.gEndDate.add(
                                                  Duration(
                                                    hours: int.parse(
                                                      _currentLottery.endTime
                                                          .substring(0, 2),
                                                    ),
                                                    minutes: int.parse(
                                                      _currentLottery.endTime
                                                          .substring(3, 5),
                                                    ),
                                                    seconds: int.parse(
                                                      _currentLottery.endTime
                                                          .substring(6, 8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Divider(
                                              color: Colors.grey.shade300,
                                              thickness: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        _currentLottery.status == 2
                                            ? RaisedButton(
                                                padding: EdgeInsets.all(10),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                //color: Colors.blueGrey,
                                                child: Text(
                                                  'در انتظار اعلام نتایج',
                                                  style: TextStyle(
                                                    //color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                //onPressed: () {},
                                              )
                                            : RaisedButton(
                                                padding: EdgeInsets.all(10),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                color: Color.fromRGBO(
                                                    227, 131, 215, 1),
                                                child: Text(
                                                  'اسامی برندگان',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                //onPressed: _launchURL,
                                                onPressed: () async {
                                                  await tryOtaUpdate();
                                                  //_showCircularProgressIndicator('');
                                                },
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
