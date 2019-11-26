import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/auth.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class RulesScreen extends StatefulWidget {
  static const routeName = '/rules';
  @override
  _RulesScreenScreenState createState() => _RulesScreenScreenState();
}

class _RulesScreenScreenState extends State<RulesScreen> {
  var _isLoading = false;
  String _rules;

  void _getRulesContent() {
    setState(() {
      _isLoading = true;
    });
    _rules = Provider.of<AuthProvider>(context, listen: false).rules;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getRulesContent();
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
                  _rules,
                ),
              ),
            ),
    );
  }
}
