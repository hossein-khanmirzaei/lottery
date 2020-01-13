import 'package:flutter/material.dart';
import 'package:lottery/widgets/rec.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/auth.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class AboutScreen extends StatefulWidget {
  static const routeName = '/about';
  @override
  _AboutScreenScreenState createState() => _AboutScreenScreenState();
}

class _AboutScreenScreenState extends State<AboutScreen> {
  var _isLoading = false;
  String _aboutUS;

  void _getAboutContent() {
    setState(() {
      _isLoading = true;
    });
    _aboutUS = Provider.of<AuthProvider>(context, listen: false).aboutUs;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getAboutContent();
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
                              right: 25, left: 10, top: 10),
                          child: Image.asset(
                            'assets/images/news-icon-menu.png',
                            height: 40,
                          ),
                        ),
                        Text(
                          'درباره ما',
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
                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 45, horizontal: 25),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.all(
                                  const Radius.circular(16.0),
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        'درباره ما',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(179, 55, 209, 1),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Divider(
                                        color: Color.fromRGBO(179, 55, 209, 1),
                                        thickness: 2,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        _aboutUS,
                                        textAlign: TextAlign.start,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
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
