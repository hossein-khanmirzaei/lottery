import 'package:flutter/material.dart';
import 'package:lottery/models/tranaction.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : Container(
              child: Center(
                  child: Column(
                children: <Widget>[
                  Text(_currentTransaction.id.toString()),
                  Text(_currentTransaction.date),
                  Text(_currentTransaction.time),
                  Text(_currentTransaction.originalAmount.toString()),
                  Text(_currentTransaction.pan1),
                  Text(_currentTransaction.buyerName),
                  Text(_currentTransaction.sellerName),
                  Text(_currentTransaction.mallName),
                  Text(_currentTransaction.confirm.toString()),
                ],
              )),
            ),
    );
  }
}
