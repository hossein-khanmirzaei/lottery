import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/screens/card_add_screen.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/card_provider.dart';

class CardListScreen extends StatefulWidget {
  static const routeName = '/cardList';
  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  var _isLoading = false;
  List _cardList = [];

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
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<CardProvider>(context, listen: false).getCardList();
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _cardList = Provider.of<CardProvider>(context, listen: false).cardList;
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
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(CardAddScreen.routeName);
        },
      ),
      body: ListView.separated(
        itemCount: _cardList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_cardList[index]['Card_Title']),
            subtitle: Text(_cardList[index]['Card_Number']),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}
