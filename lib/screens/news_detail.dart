import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/news.dart';
import 'package:lottery/widgets/rec.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/news.dart';

class NewsDetailScreen extends StatefulWidget {
  static const routeName = '/newsDetail';
  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  var _isLoading = false;
  News _currentNews;

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
    _currentNews =
        Provider.of<NewsProvider>(context, listen: false).currentNews;
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
                            child: Image.asset('assets/images/news-icon.png'),
                          ),
                          Text(
                            'اخبار',
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
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
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
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        _currentNews.title,
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
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          _currentNews.note,
                                          textAlign: TextAlign.start,
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        _currentNews.time +
                                            ' | ' +
                                            _currentNews.date,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            )
            // Container(
            //     margin: EdgeInsets.all(10),
            //     padding: EdgeInsets.all(10),
            //     child: SingleChildScrollView(
            //       child: HtmlWidget(
            //         _note,
            //       ),
            //     ),
            //   ),
            ),
      ],
    );
  }
}
