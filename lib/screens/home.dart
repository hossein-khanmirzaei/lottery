import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/news.dart';
import 'package:lottery/screens/news_detail.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/news.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<News> _news = [];
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

  Future<void> _getNewsList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<NewsProvider>(context, listen: false).fetchNews();
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _news = Provider.of<NewsProvider>(context, listen: false).newsList;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getNewsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          )
        : ListView.separated(
            itemCount: _news.length,
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
                  _news[index].title,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  _news[index].time + ' ' + _news[index].date,
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
                      Provider.of<NewsProvider>(context, listen: false)
                          .setCurrentNews(_news[index].id);
                      Navigator.of(context)
                          .pushNamed(NewsDetailScreen.routeName);
                    }),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
  }
}
