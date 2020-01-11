import 'package:flutter/material.dart';
import 'package:lottery/models/tranaction.dart';
import 'package:lottery/widgets/rec.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/transaction.dart';

class TransactionDetailScreen extends StatefulWidget {
  static const routeName = '/transactionDetail';
  @override
  _TransactionDetailScreenState createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  var _isLoading = false;
  Transaction _currentTransaction;

  void _getcurrentTransaction() {
    setState(() {
      _isLoading = true;
    });
    _currentTransaction =
        Provider.of<TransactionProvider>(context, listen: false)
            .currentTransaction;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getcurrentTransaction();
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
                              right: 25, left: 10, top: 10),
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
                                      _currentTransaction.mallName,
                                      textAlign: TextAlign.right,
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
                                          //Text(_currentTransaction.id.toString()),
                                          Text(_currentTransaction
                                              .originalAmount
                                              .toString()),
                                          Text(_currentTransaction.pan1),
                                          Text(_currentTransaction.buyerName),
                                          Text(_currentTransaction.sellerName),
                                          //Text(_currentTransaction.mallName),
                                          //Text(_currentTransaction.confirm.toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      _currentTransaction.time +
                                          ' | ' +
                                          _currentTransaction.date,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14),
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
