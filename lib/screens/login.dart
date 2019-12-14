import 'package:flutter/material.dart';
import 'package:lottery/screens/overview.dart';
import 'package:provider/provider.dart';

import 'package:lottery/providers/auth.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _username = "";
  var _password = "";
  final _form = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  var _isLoading = false;

  _submitForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return null;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .login(_username, _password);
      Navigator.of(context).pushReplacementNamed(OverviewScreen.routeName);
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

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        //autovalidate: true,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Image.asset('assets/images/logo.png'),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10),
                decoration:
                    BoxDecoration(color: Color(0x945C62).withOpacity(.25)),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: MediaQuery.of(context).size.width / 10,
                      ),
                      child: TextFormField(
                        onSaved: (value) {
                          _username = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return "لطفا نام کاربری را وارد کنید!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          hintText: 'نام کاربری',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: MediaQuery.of(context).size.width / 10,
                      ),
                      child: TextFormField(
                        onSaved: (value) {
                          _password = value;
                        },
                        onFieldSubmitted: (_) {
                          _submitForm();
                        },
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return "لطفا کلمه عبور را وارد کنید!";
                          }
                          return null;
                        },
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        focusNode: _passwordFocusNode,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          hintText: 'کلمه عبور',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _isLoading
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 17),
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 20,
                                vertical: 20),
                            child: RaisedButton(
                              onPressed: _submitForm,
                              child: Text(
                                "ورود",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              color: Color(0x395A77).withOpacity(.5),
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              // shape: RoundedRectangleBorder(
                              //   side: BorderSide(
                              //     color: Theme.of(context).accentColor,
                              //     width: 2,
                              //   ),
                              //   borderRadius: BorderRadius.circular(30),
                              // ),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                  onPressed: _submitForm,
                  child: Text(
                    "ورود",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  color: Color(0x395A77).withOpacity(.5),
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
