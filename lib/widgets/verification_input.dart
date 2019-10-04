import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:lottery/providers/auth.dart';

class VerificationCodeInput extends StatefulWidget {
  final String nationalCode;
  final String mobileNumber;
  VerificationCodeInput(this.nationalCode, this.mobileNumber);

  @override
  _VerificationCodeInputState createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
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
          .sendVerificationCode(widget.nationalCode, widget.mobileNumber, code);

      Navigator.of(context).pop();
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
    return SingleChildScrollView(
      //scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Text("کد فعال سازی"),
          SizedBox(
            height: 25,
          ),
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
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
                      var tmp = value.split('').elementAt(value.length - 1);
                      _firstController.text = tmp;
                      FocusScope.of(context)
                          .requestFocus(_secondNumberFocusNode);
                    }
                  },
                  // onSubmitted: (String value) {
                  //   FocusScope.of(context).requestFocus(_secondNumberFocusNode);
                  // },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
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
                      var tmp = value.split('').elementAt(value.length - 1);
                      _secondController.text = tmp;
                      FocusScope.of(context)
                          .requestFocus(_thirdNumberFocusNode);
                    }
                  },
                  // onSubmitted: (String value) {
                  //   FocusScope.of(context).requestFocus(_thirdNumberFocusNode);
                  // },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
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
                      var tmp = value.split('').elementAt(value.length - 1);
                      _thirdController.text = tmp;
                      FocusScope.of(context)
                          .requestFocus(_fourthNumberFocusNode);
                    }
                  },
                  // onSubmitted: (String value) {
                  //   FocusScope.of(context).requestFocus(_fourthNumberFocusNode);
                  // },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
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
                      var tmp = value.split('').elementAt(value.length - 1);
                      _fourthController.text = tmp;
                      FocusScope.of(context)
                          .requestFocus(_fifthNumberFocusNode);
                    }
                  },
                  // onSubmitted: (String value) {
                  //   FocusScope.of(context).requestFocus(_fifthNumberFocusNode);
                  // },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
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
                      var tmp = value.split('').elementAt(value.length - 1);
                      _fifthController.text = tmp;
                      FocusScope.of(context)
                          .requestFocus(_sixthNumberFocusNode);
                    }
                  },
                  // onSubmitted: (String value) {
                  //   FocusScope.of(context).requestFocus(_fifthNumberFocusNode);
                  // },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
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
                      var tmp = value.split('').elementAt(value.length - 1);
                      _sixthController.text = tmp;
                      FocusScope.of(context).unfocus();
                    }
                  },
                  //onSubmitted: (String value) {},
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          _isLoading
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 17),
                  child: CircularProgressIndicator(),
                )
              : InkWell(
                  onTap: _submitCode,
                  child: Container(
                    //width: 100.0,
                    height: 50.0,
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    decoration: BoxDecoration(
                      //color: Theme.of(context).primaryColor, // Colors.blueAccent,
                      border: Border.all(
                        color: Theme.of(context).primaryColor, //Colors.white54,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'ارسال',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).primaryColor, //Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
