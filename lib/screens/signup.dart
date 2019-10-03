import 'package:flutter/material.dart';

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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      onSaved: (value) {},
                      validator: (value) {},
                      autofocus: true,
                      keyboardType: TextInputType.number,
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
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      onSaved: (value) {},
                      validator: (value) {},
                      autofocus: true,
                      keyboardType: TextInputType.number,
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
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      onSaved: (value) {},
                      validator: (value) {},
                      autofocus: true,
                      keyboardType: TextInputType.number,
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
