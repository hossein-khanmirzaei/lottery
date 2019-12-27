import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/screens/creditcard.dart';
import 'package:lottery/screens/gift.dart';
import 'package:lottery/screens/home.dart';
import 'package:lottery/screens/store.dart';
import 'package:lottery/screens/tranaction.dart';
import 'package:lottery/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/transaction.dart';

class OverviewScreen extends StatefulWidget {
  static const routeName = '/overview';
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  int _currentIndex = 0;
  String _totalCredit = '---';
  String _totalPayment = '---';
  var _isLoading = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void _showErrorDialog(String message, [String title = 'پیام جدید']) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
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

  Future<void> _getTotalCredit() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<TransactionProvider>(context, listen: false)
          .getTotalCredit();
    } on HttpException catch (error) {
      //_showErrorDialog(error.toString());
    } catch (error) {
      //_showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _totalCredit = Provider.of<TransactionProvider>(context).totalCredit;
      _isLoading = false;
    });
  }

  Future<void> _getTotalPayment() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<TransactionProvider>(context, listen: false)
          .getTotalPayment();
    } on HttpException catch (error) {
      //_showErrorDialog(error.toString());
    } catch (error) {
      //_showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _totalPayment = Provider.of<TransactionProvider>(context).totalPayment;
      _isLoading = false;
    });
  }

  final List<Widget> _children = [
    HomeScreen(),
    TransactionScreen(),
    StoreScreen(),
    GiftScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    _getTotalCredit();
    _getTotalPayment();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        _showErrorDialog(message['notification']['body']);
        print("OnMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        //_showErrorDialog(message['notification']['body']);
        print("OnLanch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        //_showErrorDialog(message['notification']['body']);
        print("OnMResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
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
            actions: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
            ],
            bottom: (_currentIndex == 0)
                ? PreferredSize(
                    preferredSize: Size.fromHeight(150),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 120.0,
                          child: RaisedButton(
                            child: Text(
                              "مدیریت کارت",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            color: Colors.green,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(CreditCardScreen.routeName);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              'مجموع امتیاز',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                            Text(
                              'مجموع خرید',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _totalCredit != null
                                ? Text(
                                    _totalCredit,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                : Icon(
                                    Icons.block,
                                    color: Colors.white54,
                                  ),
                            _totalPayment != null
                                ? Text(
                                    _totalPayment,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                : Icon(
                                    Icons.block,
                                    color: Colors.white54,
                                  ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                      ],
                    ),
                  )
                : null,
          ),
          drawer: AppDrawer(),
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  //width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset('assets/images/home-icon.png'),
                ),
                title: Text(
                  'خانه',
                  style: TextStyle(
                    color: Colors.black, //Color(0x00417A),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  //width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset('assets/images/transaction-icon.png'),
                ),
                title: Text(
                  'تراکنش ها',
                  style: TextStyle(
                    color: Colors.black, //Color(0x00417A),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  //width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset('assets/images/store-icon.png'),
                ),
                title: Text(
                  'فروشگاه ها',
                  style: TextStyle(
                    color: Colors.black, //Color(0x00417A),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  //width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset('assets/images/gift-icon.png'),
                ),
                title: Text(
                  'نتایج قرعه کشی',
                  style: TextStyle(
                    color: Colors.black, //Color(0x00417A),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
