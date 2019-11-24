import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/news.dart';

class NewsDetailScreen extends StatefulWidget {
  static const routeName = '/newsDetail';
  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  var _isLoading = false;
  var note;

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

  Future<void> _getNote() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<NewsProvider>(context, listen: false)
          .fetchCurrentNewsDetail();
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      print(error);
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    note = Provider.of<NewsProvider>(context, listen: false).currentNews.note;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getNote();
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
                child: Text(note),
              ),
            ),
    );
  }
}
