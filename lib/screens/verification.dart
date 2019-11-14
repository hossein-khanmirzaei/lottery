import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottery/screens/overview_screen.dart';
import 'package:provider/provider.dart';

import 'package:lottery/providers/auth.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = '/verification';

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  var _isCodeReady = false;
  var _isLoading = false;

  final FocusNode _firstNumberFocusNode = FocusNode();
  final FocusNode _secondNumberFocusNode = FocusNode();
  final FocusNode _thirdNumberFocusNode = FocusNode();
  final FocusNode _fourthNumberFocusNode = FocusNode();
  final FocusNode _fifthNumberFocusNode = FocusNode();
  final FocusNode _sixthNumberFocusNode = FocusNode();

  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _fourthController = TextEditingController();
  final TextEditingController _fifthController = TextEditingController();
  final TextEditingController _sixthController = TextEditingController();

  @override
  void dispose() {
    _firstNumberFocusNode.dispose();
    _secondNumberFocusNode.dispose();
    _thirdNumberFocusNode.dispose();
    _fourthNumberFocusNode.dispose();
    _fifthNumberFocusNode.dispose();
    _sixthNumberFocusNode.dispose();
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _fourthController.dispose();
    _fifthController.dispose();
    _sixthController.dispose();
    super.dispose();
  }

  void _checkCode() {
    var code = _firstController.text +
        _secondController.text +
        _thirdController.text +
        _fourthController.text +
        _fifthController.text +
        _sixthController.text;
    setState(() {
      _isCodeReady =
          int.tryParse(code) == null || code.length < 6 ? false : true;
    });
  }

  _submitCode() async {
    var code = _firstController.text +
        _secondController.text +
        _thirdController.text +
        _fourthController.text +
        _fifthController.text +
        _sixthController.text;

    if (int.tryParse(code) == null) return;
    //final isValid = _form.currentState.validate();
    //if (!isValid) {
    //  return null;
    //}
    //_form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .sendVerificationCode(
              Provider.of<AuthProvider>(context, listen: false)
                  .userNationalCode,
              Provider.of<AuthProvider>(context, listen: false).userMobileNo,
              code);

      Navigator.of(context).pushNamedAndRemoveUntil(OverviewScreen.routeName, (Route<dynamic> route) => false);
    } catch (error) {
      _showErrorDialog(error.toString());
      print(error);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('خطا!'),
        content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "کد فعال سازی",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 30,
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                        maxLengthEnforced: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        controller: _firstController,
                        focusNode: _firstNumberFocusNode,
                        onChanged: (value) {
                          if (value.length > 0) {
                            var tmp =
                                value.split('').elementAt(value.length - 1);
                            _firstController.text = tmp;
                            FocusScope.of(context)
                                .requestFocus(_secondNumberFocusNode);
                          }
                          _checkCode();
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 30,
                      child: TextField(
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                        maxLengthEnforced: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        controller: _secondController,
                        focusNode: _secondNumberFocusNode,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context)
                                .requestFocus(_firstNumberFocusNode);
                          } else {
                            var tmp =
                                value.split('').elementAt(value.length - 1);
                            _secondController.text = tmp;
                            FocusScope.of(context)
                                .requestFocus(_thirdNumberFocusNode);
                          }
                          _checkCode();
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 30,
                      child: TextField(
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                        maxLengthEnforced: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        controller: _thirdController,
                        focusNode: _thirdNumberFocusNode,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context)
                                .requestFocus(_secondNumberFocusNode);
                          } else {
                            var tmp =
                                value.split('').elementAt(value.length - 1);
                            _thirdController.text = tmp;
                            FocusScope.of(context)
                                .requestFocus(_fourthNumberFocusNode);
                          }
                          _checkCode();
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 30,
                      child: TextField(
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                        maxLengthEnforced: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        controller: _fourthController,
                        focusNode: _fourthNumberFocusNode,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context)
                                .requestFocus(_thirdNumberFocusNode);
                          } else {
                            var tmp =
                                value.split('').elementAt(value.length - 1);
                            _fourthController.text = tmp;
                            FocusScope.of(context)
                                .requestFocus(_fifthNumberFocusNode);
                          }
                          _checkCode();
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 30,
                      child: TextField(
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                        maxLengthEnforced: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        controller: _fifthController,
                        focusNode: _fifthNumberFocusNode,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context)
                                .requestFocus(_fourthNumberFocusNode);
                          } else {
                            var tmp =
                                value.split('').elementAt(value.length - 1);
                            _fifthController.text = tmp;
                            FocusScope.of(context)
                                .requestFocus(_sixthNumberFocusNode);
                          }
                          _checkCode();
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 30,
                      child: TextField(
                        style: TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                        maxLengthEnforced: true,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                        controller: _sixthController,
                        focusNode: _sixthNumberFocusNode,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            FocusScope.of(context)
                                .requestFocus(_fifthNumberFocusNode);
                          } else {
                            var tmp =
                                value.split('').elementAt(value.length - 1);
                            _sixthController.text = tmp;
                            FocusScope.of(context).unfocus();
                          }
                          _checkCode();
                        },
                        //onSubmitted: (String value) {},
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10,
                    vertical: 10),
                child: RaisedButton(
                  onPressed: _isCodeReady ? _submitCode : null,
                  child: Text(
                    "تایید",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).accentColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10,
                    vertical: 10),
                child: OutlineButton(
                  onPressed: null,
                  child: Text(
                    "درخواست مجدد کد",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  textColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                  shape: StadiumBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
