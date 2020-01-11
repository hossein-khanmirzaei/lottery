import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/tranaction.dart';
import 'package:lottery/screens/transaction_detail.dart';
import 'package:lottery/widgets/rec.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/transaction.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Transaction> _transactions = [];
  var _isLoading = false;
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
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getTransactionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 25, left: 10, top: 10),
                    child: Image.asset(
                      'assets/images/transaction-icon.png',
                      height: 40,
                    ),
                  ),
                  Text(
                    'تراکنش',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18,
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
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: ListView.builder(
                          itemCount: _transactions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 12,
                                  right: MediaQuery.of(context).size.width / 12,
                                  top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          _transactions[index].mallName,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            _transactions[index]
                                                    .time
                                                    .toString() +
                                                ' ' +
                                                _transactions[index]
                                                    .date
                                                    .toString(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        //color: Colors.amber,
                                        ),
                                    child: IconButton(
                                      icon: Icon(Icons.search),
                                      color: Theme.of(context).errorColor,
                                      onPressed: () {
                                        Provider.of<TransactionProvider>(
                                                context,
                                                listen: false)
                                            .setCurrentTransaction(
                                                _transactions[index].id);
                                        Navigator.of(context).pushNamed(
                                            TransactionDetailScreen.routeName);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        // ListView.separated(
                        //   itemCount: _transactions.length,
                        //   itemBuilder: (context, index) {
                        //     return ListTile(
                        //       title: Text(
                        //         _transactions[index].mallName,
                        //         style: Theme.of(context).textTheme.title,
                        //       ),
                        //       subtitle: Text(
                        //         _transactions[index].time.toString() +
                        //             ' ' +
                        //             _transactions[index].date.toString(),
                        //       ),
                        //       trailing: IconButton(
                        //         icon: Icon(Icons.search),
                        //         color: Theme.of(context).errorColor,
                        //         onPressed: () {
                        //           Provider.of<TransactionProvider>(context,
                        //                   listen: false)
                        //               .setCurrentTransaction(
                        //                   _transactions[index].id);
                        //           Navigator.of(context).pushNamed(
                        //               TransactionDetailScreen.routeName);
                        //         },
                        //       ),
                        //     );
                        //   },
                        //   separatorBuilder: (context, index) {
                        //     return Divider();
                        //   },
                        // ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );

    // _isLoading
    //     ? Center(child: CircularProgressIndicator())
    //     : TransactionList(_transactions, null);

    // Container(
    //   margin: EdgeInsets.only(top: 10),
    //   child: Column(
    //     children: <Widget>[
    //       ListTile(
    //         leading: CircleAvatar(
    //           radius: 30,
    //           child: Padding(
    //             padding: EdgeInsets.all(6),
    //             child: FittedBox(
    //               child: Text('\$${_transactions[index].originalAmount}'),
    //             ),
    //           ),
    //         ),
    //         title: Text(
    //           _transactions[index].mall.toString(),
    //           style: Theme.of(context).textTheme.title,
    //         ),
    //         subtitle: Text(
    //           _transactions[index].time.toString(),
    //         ),
    //         trailing: IconButton(
    //           icon: Icon(Icons.delete),
    //           color: Theme.of(context).errorColor,
    //           onPressed: null,
    //         ),
    //       ),
    //       Divider(
    //         thickness: 1,
    //       )
    //     ],
    //   ),
    // );
  }
}
