import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/tranaction.dart';
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
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          )
        : ListView.separated(
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              return ListTile(
                // leading: CircleAvatar(
                //   radius: 30,
                //   child: Padding(
                //     padding: EdgeInsets.all(6),
                //     child: FittedBox(
                //       child: Text('\$${_transactions[index].originalAmount}'),
                //     ),
                //   ),
                // ),
                title: Text(
                  _transactions[index].mall.toString(),
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  _transactions[index].time.toString() +
                      ' ' +
                      _transactions[index].date.toString(),
                ),
                trailing: IconButton(
                    icon: Icon(Icons.search),
                    color: Theme.of(context).errorColor,
                    onPressed: null //() => deleteTx(_transactions[index].id),
                    ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
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
