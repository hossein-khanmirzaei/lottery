import 'package:flutter/material.dart';
import 'package:lottery/widgets/custome_textfield.dart';

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
                  CustomTextField(
                    icon: Icon(Icons.person),
                    hint: 'نام کاربری',
                    onSaved: null,
                    keyboardType: TextInputType.number,
                    validator: null,
                  ),
                  CustomTextField(
                    icon: Icon(Icons.lock),
                    hint: 'کلمه عبور',
                    obsecure: true,
                    onSaved: null,
                    validator: null,
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
