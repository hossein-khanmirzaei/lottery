import 'package:flutter/material.dart';
import 'package:lottery/screens/login.dart';
import 'package:lottery/screens/verification.dart';
import 'package:lottery/widgets/arc.dart';
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

  Future _submitForm() async {
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
      // appBar: AppBar(
      //   title: Text('ثبت نام'),
      // ),
      body: Form(
        key: _form,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: MyArc(
                                  diameter: 80,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 10,
                                  right: MediaQuery.of(context).size.width / 10,
                                  top: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0x945C62).withOpacity(.5),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 25,
                                        bottom: 10,
                                        left:
                                            MediaQuery.of(context).size.width /
                                                10,
                                        right:
                                            MediaQuery.of(context).size.width /
                                                10,
                                      ),
                                      child: TextFormField(
                                        onSaved: (value) {
                                          _fullname = value;
                                        },
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(
                                              _nationalCodeFocusNode);
                                        },
                                        validator: (value) {
                                          if (value.isEmpty || value == null) {
                                            return "لطفا نام و نام خانوادگی خود را وارد کنید!";
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.text,
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
                                          hintText: 'نام و نام خانوادگی',
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
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                10,
                                      ),
                                      child: TextFormField(
                                        onSaved: (value) {
                                          _nationalCode = value;
                                        },
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context).requestFocus(
                                              _mobileNumberFocusNode);
                                        },
                                        validator: (value) {
                                          if (value.isEmpty || value == null) {
                                            return "لطفا کد ملی خود را وارد کنید!";
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        focusNode: _nationalCodeFocusNode,
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
                                          hintText: 'کد ملی',
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
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                10,
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
                                        keyboardType: TextInputType.number,
                                        //textInputAction: TextInputAction.none,
                                        focusNode: _mobileNumberFocusNode,
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
                                          hintText: 'شماره موبایل',
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              //activeColor: Colors.white,
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
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              //activeColor: Colors.white,
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
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    _isLoading
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 17),
                                            child: CircularProgressIndicator(),
                                          )
                                        : Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        20,
                                                vertical: 20),
                                            child: RaisedButton(
                                              onPressed: _submitForm,
                                              child: Text(
                                                "ثبت نام",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              color: Color(0x395A77)
                                                  .withOpacity(.5),
                                              textColor: Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          Color(0x945C62).withOpacity(.75),
                                      child: Image.asset(
                                          'assets/images/user-icon.png')),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      color: Color(0x032975).withOpacity(.39),
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "حساب کاربری دارید؟",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              //fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            child: Text(
                              'وارد شوید',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
