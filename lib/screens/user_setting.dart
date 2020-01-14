import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/user.dart';
import 'package:lottery/screens/user_password.dart';
import 'package:lottery/widgets/rec.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/user.dart';

class UserSettingsScreen extends StatefulWidget {
  static const routeName = '/userSettingsScreen';
  @override
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  ResidenceType _residenceType;
  bool _smsNotify;
  bool _pushNotify;

  var _isLoading = false;

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

  Future<void> _updateResidenceTypeSetting(ResidenceType residenceType) async {
    final _preRsidenceTypeValue = _residenceType;
    setState(() {
      _residenceType = residenceType;
      _isLoading = true;
    });
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .changeResidenceTypeSetting(
        residenceType.index + 1,
      );
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      _residenceType = _preRsidenceTypeValue;
      _showErrorDialog(error.toString());
    } catch (error) {
      _residenceType = _preRsidenceTypeValue;
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
  }

  Future<void> _updateSmsNotifySetting(bool smsNotify) async {
    setState(() {
      _smsNotify = smsNotify;
      _isLoading = true;
    });
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .changeSmsNotifySetting(
        smsNotify,
      );
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      setState(() {
        _smsNotify = !smsNotify;
      });
      _showErrorDialog(error.toString());
    } catch (error) {
      setState(() {
        _smsNotify = !smsNotify;
      });
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
  }

  Future<void> _updatePushNotifySetting(bool pushNotify) async {
    setState(() {
      _pushNotify = pushNotify;
      _isLoading = true;
    });
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .changePushNotifySetting(
        pushNotify,
      );
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      setState(() {
        _pushNotify = !pushNotify;
      });
      _showErrorDialog(error.toString());
    } catch (error) {
      setState(() {
        _pushNotify = !pushNotify;
      });
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
  }

  @override
  void initState() {
    _residenceType = Provider.of<UserProvider>(context, listen: false)
        .currentUser
        .residenceType;
    _smsNotify =
        Provider.of<UserProvider>(context, listen: false).currentUser.smsNotify;
    _pushNotify = Provider.of<UserProvider>(context, listen: false)
        .currentUser
        .pushNotify;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            color: Colors.white.withOpacity(0.5),
            child: Column(
              children: <Widget>[
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(
                                right: 30, left: 10, top: 10),
                            child: Image.asset(
                              'assets/images/settings-icon-menu.png',
                              height: 40,
                            )),
                        Text(
                          'تنظیمات کاربری',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      MyRec(width: MediaQuery.of(context).size.width),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'وضعیت کاربر',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Radio(
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          value: ResidenceType.kishvand,
                                          groupValue: _residenceType,
                                          onChanged:
                                              _updateResidenceTypeSetting),
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
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          value: ResidenceType.passenger,
                                          groupValue: _residenceType,
                                          onChanged:
                                              _updateResidenceTypeSetting),
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'دریافت پیامک',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: Switch(
                                    onChanged: _updateSmsNotifySetting,
                                    value: _smsNotify,
                                    activeColor: Theme.of(context).primaryColor,
                                    inactiveThumbColor: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'دریافت نوتیفیکیشن',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: Switch(
                                    onChanged: _updatePushNotifySetting,
                                    value: _pushNotify,
                                    activeColor: Theme.of(context).primaryColor,
                                    inactiveThumbColor: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              RaisedButton(
                                padding: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: Color.fromRGBO(227, 131, 215, 1),
                                child: Text(
                                  'ذخیره',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(UserPasswordScreen.routeName);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
