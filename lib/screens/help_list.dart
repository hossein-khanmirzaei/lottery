import 'package:flutter/material.dart';
import 'package:lottery/models/help.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/screens/help_detail.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/help.dart';

class HelpListScreen extends StatefulWidget {
  static const routeName = '/helpList';
  @override
  _HelpListScreenState createState() => _HelpListScreenState();
}

class _HelpListScreenState extends State<HelpListScreen> {
  List<Help> _helpList = [];
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

  Future<void> _getHelpList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<HelpProvider>(context, listen: false).fetchHelpList();
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _helpList = Provider.of<HelpProvider>(context, listen: false).helpList;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getHelpList();
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
          : ListView.separated(
              itemCount: _helpList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  // leading: CircleAvatar(
                  //   radius: 30,
                  //   child: Padding(
                  //     padding: EdgeInsets.all(6),
                  //     child: FittedBox(
                  //       child: Text('\$${_news[index].originalAmount}'),
                  //     ),
                  //   ),
                  // ),
                  title: Text(
                    _helpList[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  // onTap: () {
                  //   Provider.of<NewsProvider>(context, listen: false)
                  //       .setCurrentNews(_news[index].id);
                  //   Navigator.of(context).pushNamed(NewsDetailScreen.routeName);
                  // },
                  trailing: IconButton(
                      icon: Icon(Icons.search),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        Provider.of<HelpProvider>(context, listen: false)
                            .setCurrentHelp(_helpList[index].id);
                        Navigator.of(context)
                            .pushNamed(HelpDetailScreen.routeName);
                      }),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
    );
  }
}
