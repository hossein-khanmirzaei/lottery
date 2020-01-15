import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var _isCodeReady = false;

  final _formKey = GlobalKey<FormState>();
  String _cardTitle = '';
  String _cardNumber = '';

  final FocusNode _firstNumberFocusNode = FocusNode();
  final FocusNode _secondNumberFocusNode = FocusNode();
  final FocusNode _thirdNumberFocusNode = FocusNode();
  final FocusNode _fourthNumberFocusNode = FocusNode();

  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _fourthController = TextEditingController();

  @override
  void dispose() {
    _firstNumberFocusNode.dispose();
    _secondNumberFocusNode.dispose();
    _thirdNumberFocusNode.dispose();
    _fourthNumberFocusNode.dispose();
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _fourthController.dispose();
    super.dispose();
  }

  void _checkCode() {
    var code = _firstController.text +
        _secondController.text +
        _thirdController.text +
        _fourthController.text;

    setState(() {
      _isCodeReady =
          int.tryParse(code) == null || code.length < 16 ? false : true;
    });
  }

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

  Future<void> _addCard(String cardTitle) async {
    var cardNumber = _firstController.text +
        _secondController.text +
        _thirdController.text +
        _fourthController.text;

    if (!_isCodeReady || int.tryParse(cardNumber) == null) return;

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
                            ),
                          ),
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
                                  decoration: InputDecoration(
                                    //hintText: 'Type Text Here...',
                                    //hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                  ),
                                  onSaved: (val) =>
                                      setState(() => _cardTitle = val),
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
                                Row(
                                  textDirection: TextDirection.ltr,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextField(
                                        //autofocus: true,
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                        maxLengthEnforced: true,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(5),
                                        ],
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white70,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 2),
                                          ),
                                        ),
                                        controller: _firstController,
                                        focusNode: _firstNumberFocusNode,
                                        onChanged: (value) {
                                          if (value.length >= 4) {
                                            var tmp = value.substring(0, 4);
                                            //.split('')
                                            //.elementAt(value.length - 1);
                                            _firstController.text = tmp;
                                            FocusScope.of(context).requestFocus(
                                                _secondNumberFocusNode);
                                          }
                                          //_checkCode();
                                        },
                                      ),
                                    ),
                                    Text(
                                      ' - ',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Flexible(
                                      child: TextField(
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                        maxLengthEnforced: true,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(5),
                                        ],
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white70,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 2),
                                          ),
                                        ),
                                        controller: _secondController,
                                        focusNode: _secondNumberFocusNode,
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            FocusScope.of(context).requestFocus(
                                                _firstNumberFocusNode);
                                          } else if (value.length >= 4) {
                                            var tmp = value.substring(0, 4);
                                            //.split('')
                                            //.elementAt(value.length - 1);
                                            _secondController.text = tmp;
                                            FocusScope.of(context).requestFocus(
                                                _thirdNumberFocusNode);
                                          }
                                          //_checkCode();
                                        },
                                      ),
                                    ),
                                    Text(
                                      ' - ',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Flexible(
                                      child: TextField(
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                        maxLengthEnforced: true,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(5),
                                        ],
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white70,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 2),
                                          ),
                                        ),
                                        controller: _thirdController,
                                        focusNode: _thirdNumberFocusNode,
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            FocusScope.of(context).requestFocus(
                                                _secondNumberFocusNode);
                                          } else if (value.length >= 4) {
                                            var tmp = value.substring(0, 4);
                                            //.split('')
                                            //.elementAt(value.length - 1);
                                            _thirdController.text = tmp;
                                            FocusScope.of(context).requestFocus(
                                                _fourthNumberFocusNode);
                                          }
                                          //_checkCode();
                                        },
                                      ),
                                    ),
                                    Text(
                                      ' - ',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Flexible(
                                      child: TextField(
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
                                        maxLengthEnforced: true,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(5),
                                        ],
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white70,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 2),
                                          ),
                                        ),
                                        controller: _fourthController,
                                        focusNode: _fourthNumberFocusNode,
                                        onChanged: (value) {
                                          if (value.isEmpty) {
                                            FocusScope.of(context).requestFocus(
                                                _thirdNumberFocusNode);
                                          } else if (value.length >= 4) {
                                            var tmp = value.substring(0, 4);
                                            //.split('')
                                            //.elementAt(value.length - 1);
                                            _fourthController.text = tmp;
                                            FocusScope.of(context).unfocus();
                                          }
                                          //_checkCode();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                          _addCard(_cardTitle);
                                        },
                                      )
                              ],
                            ),
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
