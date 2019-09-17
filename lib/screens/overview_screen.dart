import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/screens/card_list_screen.dart';
import 'package:lottery/screens/gift_screen.dart';
import 'package:lottery/screens/home_screen.dart';
import 'package:lottery/screens/shop_screen.dart';
import 'package:lottery/screens/tranaction_screen.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/overview_provider.dart';

class OverviewScreen extends StatefulWidget {
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  int _currentIndex = 0;
  // var _isLoading = false;
  String _totalCredit = '---';
  String _totalPayment = '---';
  final List<Widget> _children = [
    HomeScreen(),
    TransactionScreen(),
    ShopScreen(),
    GiftScreen(),
  ];

  @override
  void initState() {
    _getTotalCredit();
    _getTotalPayment();
    super.initState();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('خطا!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
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
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      await Provider.of<OverviewProvider>(context, listen: false)
          .getTotalCredit('2755533528');
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _totalCredit =
          Provider.of<OverviewProvider>(context, listen: false).totalCredit;
      // _isLoading = false;
    });
  }

  Future<void> _getTotalPayment() async {
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      await Provider.of<OverviewProvider>(context, listen: false)
          .getTotalPayment('2755533528');
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _totalPayment =
          Provider.of<OverviewProvider>(context, listen: false).totalPayment;
      // _isLoading = false;
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60.0),
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
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    _totalCredit,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    _totalPayment,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 120.0,
                    child: RaisedButton(
                      child: Text(
                        "افزودن کارت",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      color: Colors.green,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 120.0,
                    child: OutlineButton(
                      child: Text(
                        "لیست کارت ها",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(CardListScreen.routeName);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('خانه'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('تراکنش ها'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_mall_directory),
            title: Text('فروشگاه ها'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.redeem),
            title: Text('نتایج قرعه کشی'),
          )
        ],
      ),
    );
  }
}
