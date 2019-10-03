import 'package:flutter/material.dart';
import 'package:lottery/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ورود'),
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
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      onSaved: (value) {},
                      validator: (value) {},
                      obscureText: true,
                      autofocus: true,
                      keyboardType: TextInputType.text,
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
                  InkWell(
                    onTap: () => Provider.of<AuthProvider>(context).login("2649402032", "09355881628"),
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
                          'ورود',
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
