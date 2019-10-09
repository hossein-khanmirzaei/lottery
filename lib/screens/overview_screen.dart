import 'package:flutter/material.dart';
import 'package:lottery/screens/gift_screen.dart';
import 'package:lottery/screens/home_screen.dart';
import 'package:lottery/screens/shop_screen.dart';
import 'package:lottery/screens/tranaction_screen.dart';
import 'package:lottery/widgets/app_drawer.dart';

class OverviewScreen extends StatefulWidget {
  static const routeName = '/overview';
  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  int _currentIndex = 0;
  // var _isLoading = false;
  final List<Widget> _children = [
    HomeScreen(),
    TransactionScreen(),
    ShopScreen(),
    GiftScreen(),
  ];

  @override
  void initState() {
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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      drawer: AppDrawer(),
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
