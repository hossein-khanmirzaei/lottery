import 'package:flutter/material.dart';
import 'package:lottery/screens/creditcard.dart';

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
              leading: Icon(Icons.payment),
              title: Text('مدیریت کارت'),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(CreditCardScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
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
              leading: Icon(Icons.edit),
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
              leading: Icon(Icons.edit),
              title: Text('درباره ما'),
              onTap: () {
                //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('راهنما'),
              onTap: () {
                //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('خروج از حساب کاربری'),
              onTap: () {
                //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
