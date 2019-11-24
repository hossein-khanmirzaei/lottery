import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/auth.dart';

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
              child: Center(
                child: Text(_aboutUS),
              ),
            ),
    );
  }
}
