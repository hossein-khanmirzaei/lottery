import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/card_provider.dart';

class CardAddScreen extends StatefulWidget {
  static const routeName = '/cardAdd';
  @override
  _CardAddScreenState createState() => _CardAddScreenState();
}

class _CardAddScreenState extends State<CardAddScreen> {
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String _cardTitle = '';
  String _cardNumber = '';

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

  Future<void> _addCard(String cardTitle, String cardNumber) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<CardProvider>(context, listen: false).addCard(
        cardTitle,
        cardNumber,
      );
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _isLoading = false;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'عنوان کارت'),
              onSaved: (val) => setState(() => _cardTitle = val),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'شماره کارت'),
              onSaved: (val) => setState(() => _cardNumber = val),
            ),
            RaisedButton(
              child: Text('ثبت'),
              onPressed: () {
                final form = _formKey.currentState;
                form.save();
                print(_cardTitle);
                print(_cardNumber);
                _addCard(_cardTitle, _cardNumber);
              },
            )
          ],
        ),
      ),
    );
  }
}
