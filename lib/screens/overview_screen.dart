import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/screens/credit_card_screen.dart';
import 'package:lottery/screens/gift_screen.dart';
import 'package:lottery/screens/home_screen.dart';
import 'package:lottery/screens/shop_screen.dart';
import 'package:lottery/screens/tranaction_screen.dart';
import 'package:lottery/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/overview.dart';

class OverviewScreen extends StatefulWidget {
  static const routeName = '/overview';
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
      //_showErrorDialog(error.toString());
    } catch (error) {
      //_showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _totalCredit = Provider.of<OverviewProvider>(context).totalCredit;
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
      //_showErrorDialog(error.toString());
    } catch (error) {
      //_showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _totalPayment = Provider.of<OverviewProvider>(context).totalPayment;
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
      // appBar: AppBar(
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.notifications),
      //       onPressed: () {},
      //     ),
      //   ],
      //   bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(150),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: <Widget>[
      //             Text(
      //               'مجموع امتیاز',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 24.0,
      //               ),
      //             ),
      //             Text(
      //               'مجموع خرید',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 24.0,
      //               ),
      //             ),
      //           ],
      //         ),
      //         SizedBox(height: 25.0),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             _totalCredit != null
      //                 ? Text(
      //                     _totalCredit,
      //                     textAlign: TextAlign.center,
      //                     style: TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 20,
      //                     ),
      //                   )
      //                 : Icon(
      //                     Icons.block,
      //                     color: Colors.white54,
      //                   ),
      //             _totalPayment != null
      //                 ? Text(
      //                     _totalPayment,
      //                     textAlign: TextAlign.center,
      //                     style: TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 20,
      //                     ),
      //                   )
      //                 : Icon(
      //                     Icons.block,
      //                     color: Colors.white54,
      //                   ),
      //           ],
      //         ),
      //         SizedBox(height: 15.0),
      //         ButtonTheme(
      //           minWidth: 120.0,
      //           child: RaisedButton(
      //             child: Text(
      //               "مدیریت کارت",
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 16,
      //               ),
      //             ),
      //             color: Colors.green,
      //             onPressed: () {
      //               Navigator.of(context).pushNamed(CreditCardScreen.routeName);
      //             },
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(20.0),
      //             ),
      //           ),
      //         ),
      //         SizedBox(height: 15.0),
      //       ],
      //     ),
      //   ),
      // ),
      //drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Sample Slivers"),
            leading: Icon(Icons.menu),
            backgroundColor: Colors.orangeAccent,
            floating: false,
            pinned: true,
            snap: false,
          ),
          
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                leading: Icon(Icons.volume_off),
                title: Text("Volume Off"),
              ),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(
                  leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(
                  leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(
                  leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(
                  leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(
                  leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(
                  leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(
                  leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(
                  leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(
                  leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ]),
          )
        ],

        //child: _children[_currentIndex],
      ),
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
