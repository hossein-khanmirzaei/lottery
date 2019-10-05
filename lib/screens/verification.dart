import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lottery/providers/auth.dart';
import 'package:lottery/widgets/verification_input.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = '/verification';

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  var _isLoading = false;
  _submitCode() async {
    var code = "";
    if (int.tryParse(code) == null) return;
    //final isValid = _form.currentState.validate();
    //if (!isValid) {
    //  return null;
    //}
    //_form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .sendVerificationCode(
              Provider.of<AuthProvider>(context, listen: false)
                  .userNationalCode,
              Provider.of<AuthProvider>(context, listen: false).userMobileNo,
              code);

      Navigator.of(context).pop();
    } catch (error) {
      _showErrorDialog(error.toString());
      //print(error);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('خطا!'),
        content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "کد فعال سازی",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              VerificationCodeInput(_submitCode),
            ],
          ),
        ),
      ),
    );
  }
}
