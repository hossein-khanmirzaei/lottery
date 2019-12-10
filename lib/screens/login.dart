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
                // margin: EdgeInsets.symmetric(
                //     horizontal: MediaQuery.of(context).size.width / 20,
                //     vertical: 10),
                child: Image.asset('assets/images/logo.png'),
              ),
              Column(
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
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return "لطفا نام کاربری را وارد کنید!";
                        }
                        return null;
                      },
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black26,
                          ),
                          hintText: 'نام کاربری',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 3,
                            ),
                          ),
                          prefixIcon: Padding(
                            child: IconTheme(
                              data: IconThemeData(
                                color: Theme.of(context).primaryColor,
                                size: 32,
                              ),
                              child: Icon(Icons.person),
                            ),
                            padding: EdgeInsets.only(left: 0, right: 25),
                          )),
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
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      focusNode: _passwordFocusNode,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black26,
                          ),
                          hintText: 'کلمه عبور',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 3,
                            ),
                          ),
                          prefixIcon: Padding(
                            child: IconTheme(
                              data: IconThemeData(
                                color: Theme.of(context).primaryColor,
                                size: 32,
                              ),
                              child: Icon(Icons.lock),
                            ),
                            padding: EdgeInsets.only(left: 0, right: 25),
                          )),
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
                                  MediaQuery.of(context).size.width / 10,
                              vertical: 10),
                          child: RaisedButton(
                            onPressed: _submitForm,
                            child: Text(
                              "ورود",
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
                  // InkWell(
                  //   onTap: _submitForm,
                  //   child: Container(
                  //     //width: 100.0,
                  //     height: 50.0,
                  //     margin: EdgeInsets.symmetric(
                  //         horizontal: 25, vertical: 10),
                  //     decoration: BoxDecoration(
                  //       color: Theme.of(context)
                  //           .primaryColor, // Colors.blueAccent,
                  //       border: Border.all(
                  //         color: Theme.of(context)
                  //             .accentColor, //Colors.white54,
                  //         width: 2.0,
                  //       ),
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         'ورود',
                  //         style: TextStyle(
                  //           fontSize: 18.0,
                  //           color: Theme.of(context)
                  //               .accentColor, //Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
