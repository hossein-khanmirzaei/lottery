import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/widgets/rec.dart';
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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(
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
                                'assets/images/card-icon-menu.png',
                                height: 40,
                              )),
                          Text(
                            'کارت جدید',
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
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'عنوان کارت'),
                                onSaved: (val) =>
                                    setState(() => _cardTitle = val),
                              ),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'شماره کارت'),
                                onSaved: (val) =>
                                    setState(() => _cardNumber = val),
                              ),
                              _isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                    )
                                  : RaisedButton(
                                      child: Text('ثبت'),
                                      onPressed: () {
                                        final form = _formKey.currentState;
                                        form.save();
                                        _addCard(_cardTitle, _cardNumber);
                                      },
                                    )
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
      ),
    );
  }
}
