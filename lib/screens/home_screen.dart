import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/tranaction.dart';
import 'package:lottery/screens/credit_card_screen.dart';
import 'package:lottery/widgets/transaction_list.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/transactions.dart';
import 'package:lottery/providers/overview.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _totalCredit = '---';
  String _totalPayment = '---';
  List<Transaction> _transactions = [];
  var _isLoading = false;

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
    setState(() {
      _isLoading = true;
    });
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
      _isLoading = false;
    });
  }

  Future<void> _getTotalPayment() async {
    setState(() {
      _isLoading = true;
    });
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
      _isLoading = false;
    });
  }

  Future<void> _getTransactionList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<TransactionProvider>(context, listen: false)
          .fetchTransactions();
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _transactions =
          Provider.of<TransactionProvider>(context, listen: false).transactions;
      _transactions.add(_transactions[0]);
      _transactions.add(_transactions[0]);
      _transactions.add(_transactions[0]);
      _transactions.add(_transactions[0]);
      _transactions.add(_transactions[0]);
      _transactions.add(_transactions[0]);
      _transactions.add(_transactions[0]);
      _transactions.add(_transactions[0]);
      _transactions.add(_transactions[0]);
      _transactions.add(_transactions[0]);
      _transactions.add(_transactions[0]);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getTotalCredit();
    _getTotalPayment();
    _getTransactionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text(""),
          floating: false,
          pinned: true,
          snap: false,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return TransactionList(_transactions, null);
            },
          ),
        )
      ],

      //child: _children[_currentIndex],
    );

    // return Column(
    //   children: <Widget>[
    //     Expanded(
    //       child: CustomScrollView(
    //         slivers: <Widget>[
    //           SliverAppBar(
    //             title: Text(""),
    //             floating: false,
    //             pinned: true,
    //             snap: false,
    //             expandedHeight: 250,
    //             flexibleSpace: FlexibleSpaceBar(
    //               background: Container(
    //                 margin: EdgeInsets.only(top: 50),
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: <Widget>[
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       children: <Widget>[
    //                         Text(
    //                           'مجموع امتیاز',
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 24.0,
    //                           ),
    //                         ),
    //                         Text(
    //                           'مجموع خرید',
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 24.0,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     SizedBox(height: 25.0),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       children: [
    //                         _totalCredit != null
    //                             ? Text(
    //                                 _totalCredit,
    //                                 textAlign: TextAlign.center,
    //                                 style: TextStyle(
    //                                   color: Colors.white,
    //                                   fontSize: 20,
    //                                 ),
    //                               )
    //                             : Icon(
    //                                 Icons.block,
    //                                 color: Colors.white54,
    //                               ),
    //                         _totalPayment != null
    //                             ? Text(
    //                                 _totalPayment,
    //                                 textAlign: TextAlign.center,
    //                                 style: TextStyle(
    //                                   color: Colors.white,
    //                                   fontSize: 20,
    //                                 ),
    //                               )
    //                             : Icon(
    //                                 Icons.block,
    //                                 color: Colors.white54,
    //                               ),
    //                       ],
    //                     ),
    //                     SizedBox(height: 15.0),
    //                     ButtonTheme(
    //                       minWidth: 120.0,
    //                       child: RaisedButton(
    //                         child: Text(
    //                           "مدیریت کارت",
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 16,
    //                           ),
    //                         ),
    //                         color: Colors.green,
    //                         onPressed: () {
    //                           Navigator.of(context)
    //                               .pushNamed(CreditCardScreen.routeName);
    //                         },
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(20.0),
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(height: 15.0),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     _isLoading
    //         ? Center(child: CircularProgressIndicator())
    //         : TransactionList(_transactions, null),
    //   ],
    // );

    // ListView.separated(
    //   itemCount: _transactionList.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       title: Text(_transactionList[index]['User_Purchase_ID']),
    //     );
    //   },
    //   separatorBuilder: (context, index) {
    //     return Divider();
    //   },
    // );
  }
}
