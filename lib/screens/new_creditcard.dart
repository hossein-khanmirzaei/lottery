import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/creditcard.dart';

class NewCreditCardScreen extends StatefulWidget {
  static const routeName = '/newCreditCard';
  @override
  _NewCreditCardScreenState createState() => _NewCreditCardScreenState();
}

class _NewCreditCardScreenState extends State<NewCreditCardScreen> {
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String _cardTitle = '';
  String _cardNumber = '';

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
      await Provider.of<CreditCardProvider>(context, listen: false).addCard(
        cardTitle,
        cardNumber,
      );
      setState(() {
        _isLoading = false;
        Navigator.of(context).pop();
      });
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
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
