import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/transaction_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _transactionList = [];

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

  Future<void> _getTransactionList() async {
    // setState(() {
    //   _isLoading = true;
    // });
    try {
      await Provider.of<TransactionProvider>(context, listen: false)
          .getTransactionList();
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _transactionList =
          Provider.of<TransactionProvider>(context, listen: false)
              .transactionList;
      // _isLoading = false;
    });
  }

  @override
  void initState() {
    _getTransactionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _transactionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_transactionList[index]['User_Purchase_ID']),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
