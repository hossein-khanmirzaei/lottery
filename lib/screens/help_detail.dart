import 'package:flutter/material.dart';
import 'package:lottery/models/help.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/widgets/rec.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/help.dart';

class HelpDetailScreen extends StatefulWidget {
  static const routeName = '/helpDetail';
  @override
  _HelpDetailScreenState createState() => _HelpDetailScreenState();
}

class _HelpDetailScreenState extends State<HelpDetailScreen> {
  var _isLoading = false;
  Help _currentHelp;

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
    _currentHelp =
        Provider.of<HelpProvider>(context, listen: false).currentHelpContent;
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
                              right: 35, left: 10, top: 10),
                          child: Image.asset(
                            'assets/images/book-icon-menu.png',
                            height: 40,
                          ),
                        ),
                        Text(
                          'راهنما',
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
                                        _currentHelp.title,
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
                                        _currentHelp.content,
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

    // Scaffold(
    //   appBar: AppBar(),
    //   body: _isLoading
    //       ? Center(
    //           child: CircularProgressIndicator(
    //             backgroundColor: Theme.of(context).primaryColor,
    //           ),
    //         )
    //       : Container(
    //           margin: EdgeInsets.all(10),
    //           padding: EdgeInsets.all(10),
    //           child: SingleChildScrollView(
    //             child: HtmlWidget(
    //               _content,
    //             ),
    //           ),
    //         ),
    // );
  }
}
