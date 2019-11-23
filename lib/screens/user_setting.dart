import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/user.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/user.dart';

class UserSettingsScreen extends StatefulWidget {
  static const routeName = '/userSettingsScreen';
  @override
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  ResidenceType _residenceType = ResidenceType.kishvand;
  bool _smsNotify = false;
  bool _pushNotify = false;

  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _onSmsNotifySwitchChanged(bool value) {
    setState(() {
      _smsNotify = value;
    });
  }

  void _onPushNotifySwitchChanged(bool value) {
    setState(() {
      _pushNotify = value;
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

  Future<void> _updateSettings(
      bool residenceType, bool smsNotify, bool pushNotify) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .changeUserSettings(
        residenceType,
        smsNotify,
        pushNotify,
      );
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
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
            Center(
              child: Transform.scale(
                scale: 1.5,
                child: Switch(
                  onChanged: _onSmsNotifySwitchChanged,
                  value: _smsNotify,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveThumbColor: Colors.blueGrey,
                ),
              ),
            ),
            Center(
              child: Transform.scale(
                scale: 1.5,
                child: Switch(
                  onChanged: _onPushNotifySwitchChanged,
                  value: _pushNotify,
                  activeColor: Theme.of(context).primaryColor,
                  inactiveThumbColor: Colors.blueGrey,
                ),
              ),
            ),
            RaisedButton(
              child: Text('ثبت'),
              onPressed: () {
                final form = _formKey.currentState;
                form.save();
                //_addCard(_cardTitle, _cardNumber);
              },
            )
          ],
        ),
      ),
    );
  }
}
