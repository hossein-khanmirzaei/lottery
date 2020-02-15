import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottery/models/store.dart';
import 'package:lottery/widgets/rec.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/store.dart';

class LotteryDetailScreen extends StatefulWidget {
  static const routeName = '/lotteryDetail';
  @override
  _LotteryDetailScreenState createState() => _LotteryDetailScreenState();
}

class _LotteryDetailScreenState extends State<LotteryDetailScreen> {
  var _isLoading = false;
  Store _currentStore;

  void _getcurrentStoreDetail() {
    setState(() {
      _isLoading = true;
    });
    _currentStore =
        Provider.of<StoreProvider>(context, listen: false).currentStore;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getcurrentStoreDetail();
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
                              right: 30, left: 20, top: 10, bottom: 10),
                          child: Icon(
                            FontAwesomeIcons.store,
                            color: Colors.deepPurple,
                            size: 36,
                          ),
                        ),
                        Text(
                          'جزئیات فروشگاه',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 20,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      _currentStore.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromRGBO(179, 55, 209, 1),
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
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('نوع فروشگاه'),
                                              Text(_currentStore.type
                                                  .toString()),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Divider(
                                              color: Colors.grey.shade300,
                                              thickness: 2,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('دسته بندی'),
                                              Text(_currentStore.subType),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Divider(
                                              color: Colors.grey.shade300,
                                              thickness: 2,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('شماره واحد'),
                                              Text(_currentStore.unitNumber),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Divider(
                                              color: Colors.grey.shade300,
                                              thickness: 2,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('شماره تماس'),
                                              Text(_currentStore.phoneNumber),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Divider(
                                              color: Colors.grey.shade300,
                                              thickness: 2,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('شماره فکس'),
                                              Text(
                                                _currentStore.faxNumber,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Divider(
                                              color: Colors.grey.shade300,
                                              thickness: 2,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('آدرس'),
                                              Text(
                                                _currentStore.address,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
