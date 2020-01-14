import 'package:flutter/material.dart';
import 'package:lottery/models/creditcard.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/widgets/credit_card_list.dart';
import 'package:lottery/widgets/rec.dart';
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
                            'جزئیات کارت',
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
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'عنوان کارت',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              TextFormField(
                                //autofocus: true,
                                initialValue: _currentCreditCard.title,
                                //autocorrect: true,
                                decoration: InputDecoration(
                                  //hintText: 'Type Text Here...',
                                  //hintStyle: TextStyle(color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                ),
                                onSaved: (val) =>
                                    setState(() => _newCardTitle = val),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'شماره کارت',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              TextFormField(
                                enabled: false,
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                //autocorrect: true,
                                decoration: InputDecoration(
                                  hintText: _currentCreditCard.cardNumber,
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                ),
                                // onSaved: (val) =>
                                //     setState(() => _cardNumber = val),
                              ),
                              // TextFormField(
                              //   initialValue: _currentCreditCard.title,
                              //   decoration:
                              //       InputDecoration(labelText: 'عنوان کارت'),
                              //   onSaved: (val) =>
                              //       setState(() => _newCardTitle = val),
                              // ),
                              //Text(_currentCreditCard.cardNumber),
                              SizedBox(height: 30),
                              _isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                    )
                                  : RaisedButton(
                                      padding: EdgeInsets.all(10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      color: Color.fromRGBO(227, 131, 215, 1),
                                      child: Text(
                                        'ثبت',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      onPressed: () {
                                        final form = _formKey.currentState;
                                        form.save();
                                        _editCreditCard(_newCardTitle);
                                      },
                                    )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
