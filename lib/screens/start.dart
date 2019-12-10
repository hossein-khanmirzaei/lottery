import 'package:flutter/material.dart';

import 'package:lottery/screens/login.dart';
import 'package:lottery/screens/signup.dart';

enum AuthMode { Signup, Login }

class StartScreen extends StatelessWidget {
  static const routeName = '/intro';

  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;
    //AuthMode _authMode = AuthMode.Login;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3,
                // margin: EdgeInsets.symmetric(
                //     horizontal: MediaQuery.of(context).size.width / 20,
                //     vertical: 10),
                child: Image.asset('assets/images/logo.png'),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10,
                    vertical: 10),
                child: RaisedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(LoginScreen.routeName),
                  child: Text(
                    "ورود",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).accentColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10,
                    vertical: 10),
                child: RaisedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(SignupScreen.routeName),
                  child: Text(
                    "ثبت نام",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).accentColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class AuthCard extends StatefulWidget {
//   const AuthCard({
//     Key key,
//   }) : super(key: key);

//   @override
//   _AuthCardState createState() => _AuthCardState();
// }

// class _AuthCardState extends State<AuthCard> {
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   AuthMode _authMode = AuthMode.Login;
//   ResidenceType _residenceType = ResidenceType.Kishvand;
//   Map<String, String> _authData = {
//     'Full_Name': '',
//     'National_ID': '',
//     'Mobile_No': '',
//     'Residence_Type': '1',
//   };
//   var _isLoading = false;
//   final _passwordController = TextEditingController();

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text('خطا!'),
//         content: Text(message),
//         actions: <Widget>[
//           FlatButton(
//             child: Text('بستن'),
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//           )
//         ],
//       ),
//     );
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState.validate()) {
//       // Invalid!
//       return;
//     }
//     _formKey.currentState.save();
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       if (_authMode == AuthMode.Login) {
//         await Provider.of<AuthProvider>(context, listen: false).login(
//           _authData['National_ID'],
//           _authData['Mobile_No'],
//         );
//       } else {
//         await Provider.of<AuthProvider>(context, listen: false)
//             .signup(
//           _authData['Full_Name'],
//           _authData['National_ID'],
//           _authData['Mobile_No'],
//           _authData['Residence_Type'],
//         )
//             .then((_) async {
//           await Provider.of<AuthProvider>(context, listen: false).login(
//             _authData['National_ID'],
//             _authData['Mobile_No'],
//           );
//         });
//       }
//     } on HttpException catch (error) {
//       _showErrorDialog(error.toString());
//     } catch (error) {
//       _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
//     }

//     setState(() {
//       _isLoading = false;
//     });
//   }

//   void _switchAuthMode() {
//     if (_authMode == AuthMode.Login) {
//       setState(() {
//         _authMode = AuthMode.Signup;
//       });
//     } else {
//       setState(() {
//         _authMode = AuthMode.Login;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     return Center(
//       child: Container(
//         height: _authMode == AuthMode.Signup ? 320 : 260,
//         constraints:
//             BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 520 : 430),
//         width: deviceSize.width * 0.75,
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 if (_authMode == AuthMode.Signup)
//                   TextFormField(
//                     key: UniqueKey(),
//                     decoration:
//                         InputDecoration(labelText: 'نام و نام خانوادگی'),
//                     keyboardType: TextInputType.text,
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'نام نامعتبر است!';
//                       }
//                     },
//                     onSaved: (value) {
//                       _authData['Full_Name'] = value;
//                     },
//                   ),
//                 TextFormField(
//                   key: UniqueKey(),
//                   decoration: InputDecoration(labelText: 'کد ملی'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'کد ملی نامعتبر است!';
//                     }
//                   },
//                   onSaved: (value) {
//                     _authData['National_ID'] = value;
//                   },
//                 ),
//                 TextFormField(
//                   key: UniqueKey(),
//                   decoration: InputDecoration(labelText: 'شماره موبایل'),
//                   obscureText: false,
//                   controller: _passwordController,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'شماره موبایل نامعتبر است!';
//                     }
//                   },
//                   onSaved: (value) {
//                     _authData['Mobile_No'] = value;
//                   },
//                 ),
//                 ListTile(
//                   title: const Text('کیشوند'),
//                   leading: Radio(
//                     value: ResidenceType.Kishvand,
//                     groupValue: _residenceType,
//                     onChanged: (ResidenceType value) {
//                       setState(() {
//                         _residenceType = value;
//                         _authData['Residence_Type'] = '1';
//                       });
//                     },
//                   ),
//                 ),
//                 ListTile(
//                   title: const Text('غیر کیشوند'),
//                   leading: Radio(
//                     value: ResidenceType.NotKishvand,
//                     groupValue: _residenceType,
//                     onChanged: (ResidenceType value) {
//                       setState(() {
//                         _residenceType = value;
//                         _authData['Residence_Type'] = '2';
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 if (_isLoading)
//                   CircularProgressIndicator()
//                 else
//                   RaisedButton(
//                     child:
//                         Text(_authMode == AuthMode.Login ? 'ورود' : 'ثبت نام'),
//                     onPressed: _submit,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
//                     color: Theme.of(context).primaryColor,
//                     textColor: Theme.of(context).primaryTextTheme.button.color,
//                   ),
//                 FlatButton(
//                   child: Text(
//                       '${_authMode == AuthMode.Login ? 'ثبت نام' : 'ورود'}'),
//                   onPressed: _switchAuthMode,
//                   padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
//                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   textColor: Theme.of(context).primaryColor,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
