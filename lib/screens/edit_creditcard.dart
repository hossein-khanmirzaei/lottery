import 'package:flutter/material.dart';
import 'package:lottery/models/creditcard.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/widgets/credit_card_list.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/creditcard.dart';

class EditCreditCardScreen extends StatefulWidget {
  static const routeName = '/editCreditCard';
  @override
  _EditCreditCardScreen createState() => _EditCreditCardScreen();
}

class _EditCreditCardScreen extends State<EditCreditCardScreen> {
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  String _newCardTitle;
  CreditCard _currentCreditCard;

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

  Future<void> _getCurrentCreditCard() async {
    setState(() {
      _isLoading = true;
    });
    _currentCreditCard =
        Provider.of<CreditCardProvider>(context, listen: false).currentCard;
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _editCreditCard(String cardTitle) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<CreditCardProvider>(context, listen: false)
          .editCurrentCard(cardTitle);
      setState(() {
        _isLoading = false;
        Navigator.of(context).pop();
      });
    } on HttpException catch (error) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(error.toString());
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
  }

  @override
  void initState() {
    _getCurrentCreditCard();
    super.initState();
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
              initialValue: _currentCreditCard.title,
              decoration: InputDecoration(labelText: 'عنوان کارت'),
              onSaved: (val) => setState(() => _newCardTitle = val),
            ),
            Text(_currentCreditCard.cardNumber),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  )
                : RaisedButton(
                    child: Text('ثبت'),
                    onPressed: () {
                      final form = _formKey.currentState;
                      form.save();
                      _editCreditCard(_newCardTitle);
                    },
                  )
          ],
        ),
      ),
    );
  }
}
