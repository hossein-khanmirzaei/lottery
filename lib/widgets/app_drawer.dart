import 'package:flutter/material.dart';
import 'package:lottery/screens/about.dart';
import 'package:lottery/screens/creditcard.dart';
import 'package:lottery/screens/help_list.dart';
import 'package:lottery/screens/login.dart';
import 'package:lottery/screens/rules.dart';
import 'package:lottery/screens/user_password.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/auth.dart';
import 'package:lottery/screens/user_setting.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(236, 236, 236, 1),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width / 3,
                child: Image.asset('assets/images/logo-menu.png'),
              ),
              Divider(),
              ListTile(
                leading: Image.asset('assets/images/card-icon-menu.png'),
                title: Text('مدیریت کارت'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(CreditCardScreen.routeName);
                },
              ),
              Divider(),
              ListTile(
                leading: Image.asset('assets/images/web-icon-menu.png'),
                title: Text('تغییر کلمه عبور'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(UserPasswordScreen.routeName);
                },
              ),
              Divider(),
              ListTile(
                leading: Image.asset('assets/images/settings-icon-menu.png'),
                title: Text('تنظیمات کاربری'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(UserSettingsScreen.routeName);
                },
              ),
              Divider(),
              ListTile(
                leading:
                    Image.asset('assets/images/notification-icon-menu.png'),
                title: Text('بروز رسانی'),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Image.asset('assets/images/book-icon-menu.png'),
                title: Text('قوانین و مقررات'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(RulesScreen.routeName);
                },
              ),
              Divider(),
              ListTile(
                leading: Image.asset('assets/images/news-icon-menu.png'),
                title: Text('درباره ما'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(AboutScreen.routeName);
                },
              ),
              Divider(),
              ListTile(
                leading: Image.asset('assets/images/help-icon-menu.png'),
                title: Text('راهنما'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(HelpListScreen.routeName);
                },
              ),
              Divider(),
              ListTile(
                leading: Image.asset('assets/images/bomb-icon-menu.png'),
                title: Text('خروج از حساب کاربری'),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.routeName, (Route<dynamic> route) => false);
                  Provider.of<AuthProvider>(context, listen: false).logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
