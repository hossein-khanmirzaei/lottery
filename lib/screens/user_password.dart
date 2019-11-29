import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/user.dart';
import 'package:lottery/screens/login.dart';
import 'package:lottery/screens/overview.dart';
import 'package:lottery/screens/start.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/auth.dart';
import 'package:lottery/providers/user.dart';

class UserPasswordScreen extends StatefulWidget {
  static const routeName = '/userPasswordScreen';
  @override
  _UserPasswordScreenState createState() => _UserPasswordScreenState();
}

class _UserPasswordScreenState extends State<UserPasswordScreen> {
  String _currentpassword = '';
  String _newPassword = '';
  String _newPasswordRepeat = '';

  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _showErrorDialog(String message) async {
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

  Future<void> _updateUserPassword(
      String currentPassword, String newPassword) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .changeUserPassword(currentPassword, newPassword);
      setState(() {
        _isLoading = false;
      });
      //await _showErrorDialog('کلمه عبور با موفقیت تغییر کرد.');
      Navigator.of(context).pushNamedAndRemoveUntil(
          LoginScreen.routeName, (Route<dynamic> route) => false);
      Provider.of<AuthProvider>(context, listen: false).logout();
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      print(error);
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'کلمه عبور فعلی'),
              onSaved: (val) => setState(() => _currentpassword = val),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'کلمه عبور جدید'),
              onSaved: (val) => setState(() => _newPassword = val),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'تکرار کلمه عبور جدید'),
              onSaved: (val) => setState(() => _newPasswordRepeat = val),
            ),
            RaisedButton(
              child: Text('ثبت'),
              onPressed: () {
                final form = _formKey.currentState;
                form.save();
                if (_newPassword != _newPasswordRepeat)
                  _showErrorDialog('پسورد جدید مطابقت ندارد!');
                else
                  _updateUserPassword(_currentpassword, _newPassword);
              },
            )
          ],
        ),
      ),
    );
  }
}
