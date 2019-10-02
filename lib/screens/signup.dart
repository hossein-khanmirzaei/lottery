import 'package:flutter/material.dart';
import 'package:lottery/widgets/custome_textfield.dart';

enum ResidenceType { kishvand, passenger }

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  ResidenceType _residenceType = ResidenceType.kishvand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ثبت نام'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  CustomTextField(
                    icon: Icon(Icons.person),
                    hint: 'نام و نام خانوادگی',
                    onSaved: null,
                    keyboardType: TextInputType.number,
                    validator: null,
                  ),
                  CustomTextField(
                    icon: Icon(Icons.info),
                    hint: 'کد ملی',
                    obsecure: false,
                    onSaved: null,
                    validator: null,
                  ),
                  CustomTextField(
                    icon: Icon(Icons.phone),
                    hint: 'شماره موبایل',
                    obsecure: false,
                    onSaved: null,
                    validator: null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Radio(
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
                  InkWell(
                    onTap: () => null,
                    //Navigator.of(context).po(LoginScreen.routeName),
                    child: Container(
                      //width: 100.0,
                      height: 50.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .primaryColor, // Colors.blueAccent,
                        border: Border.all(
                          color:
                              Theme.of(context).accentColor, //Colors.white54,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'ثبت نام',
                          style: TextStyle(
                            fontSize: 18.0,
                            color:
                                Theme.of(context).accentColor, //Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
