import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: HtmlWidget(
                  _aboutUS,
                ),
                // RichText(
                //   //textDirection: TextDirection.rtl,
                //   textAlign: TextAlign.justify,
                //   softWrap: true,
                //   text: TextSpan(
                //     text: _aboutUS,
                //     style: TextStyle(
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
              ),
            ),
    );
  }
}
