import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/help.dart';

import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class HelpDetailScreen extends StatefulWidget {
  static const routeName = '/helpDetail';
  @override
  _HelpDetailScreenState createState() => _HelpDetailScreenState();
}

class _HelpDetailScreenState extends State<HelpDetailScreen> {
  var _isLoading = false;
  var _content;

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

  Future<void> _getContent() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<HelpProvider>(context, listen: false)
          .fetchCurrentHelpContent();
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    _content = Provider.of<HelpProvider>(context, listen: false)
        .currentHelpContent
        .content;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: HtmlWidget(
                  _content,
                ),
              ),
            ),
    );
  }
}
