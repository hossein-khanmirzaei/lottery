import 'package:flutter/material.dart';
import 'package:lottery/screens/verification.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/auth.dart';
import 'package:lottery/models/user.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _fullname = "";
  var _nationalCode = "";
  var _mobileNumber = "";
  ResidenceType _residenceType = ResidenceType.kishvand;
  final _form = GlobalKey<FormState>();
  final _nationalCodeFocusNode = FocusNode();
  final _mobileNumberFocusNode = FocusNode();
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
      await Provider.of<AuthProvider>(context, listen: false).signup(_fullname,
          _nationalCode, _mobileNumber, (_residenceType.index + 1).toString());

      await Navigator.of(context).pushNamed(VerificationScreen.routeName);

      //Navigator.of(context).pop();
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
    _nationalCodeFocusNode.dispose();
    _mobileNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ثبت نام'),
      ),
      body: Form(
        key: _form,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: MediaQuery.of(context).size.width / 10,
                      ),
                      child: TextFormField(
                        onSaved: (value) {
                          _fullname = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_nationalCodeFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return "لطفا نام و نام خانوادگی خود را وارد کنید!";
                          }
                          return null;
                        },
                        autofocus: true,
                        keyboardType: TextInputType.text,
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
                            hintText: 'نام و نام خانوادگی',
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
                          _nationalCode = value;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_mobileNumberFocusNode);
                        },
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return "لطفا کد ملی خود را وارد کنید!";
                          }
                          return null;
                        },
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        focusNode: _nationalCodeFocusNode,
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
                            hintText: 'کد ملی',
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
                                child: Icon(Icons.info),
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
                          _mobileNumber = value;
                        },
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return "لطفا شماره موبایل خود را وارد کنید!";
                          }
                          return null;
                        },
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        //textInputAction: TextInputAction.none,
                        focusNode: _mobileNumberFocusNode,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black26,
                            ),
                            hintText: 'شماره موبایل',
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
                                child: Icon(Icons.phone),
                              ),
                              padding: EdgeInsets.only(left: 0, right: 25),
                            )),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Radio(
                              activeColor: Theme.of(context).primaryColor,
                              value: ResidenceType.kishvand,
                              groupValue: _residenceType,
                              onChanged: (ResidenceType value) {
                                setState(() {
                                  _residenceType = value;
                                });
                              },
                            ),
                            Text(
                              'کیشوند',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              activeColor: Theme.of(context).primaryColor,
                              value: ResidenceType.passenger,
                              groupValue: _residenceType,
                              onChanged: (ResidenceType value) {
                                setState(() {
                                  _residenceType = value;
                                });
                              },
                            ),
                            Text(
                              'مسافر',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
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
                                "ثبت نام",
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
                    //                 onTap: _submitForm,
                    //                 child: Container(
                    //                   //width: 100.0,
                    //                   height: 50.0,
                    //                   margin: EdgeInsets.symmetric(
                    //                       horizontal: 25, vertical: 10),
                    //                   decoration: BoxDecoration(
                    //                     color: Theme.of(context)
                    //                         .primaryColor, // Colors.blueAccent,
                    //                     border: Border.all(
                    //                       color: Theme.of(context)
                    //                           .accentColor, //Colors.white54,
                    //                       width: 2.0,
                    //                     ),
                    //                     borderRadius: BorderRadius.circular(30),
                    //                   ),
                    //                   child: Center(
                    //                     child: Text(
                    //                       'ثبت نام',
                    //                       style: TextStyle(
                    //                         fontSize: 18.0,
                    //                         color: Theme.of(context)
                    //                             .accentColor, //Colors.white,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
