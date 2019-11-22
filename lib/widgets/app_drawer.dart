import 'package:flutter/material.dart';
import 'package:lottery/screens/creditcard.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              leading: Icon(Icons.settings),
              title: Text('تنظیمات'),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('مدیریت کارت'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(CreditCardScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('تغییر کلمه عبور'),
              onTap: () {
                //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('تنظیمات کاربری'),
              onTap: () {
                //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.update),
              title: Text('بروز رسانی'),
              onTap: () {
                //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('قوانین و مقررات'),
              onTap: () {
                //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('درباره ما'),
              onTap: () {
                //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('راهنما'),
              onTap: () {
                //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('خروج از حساب کاربری'),
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
