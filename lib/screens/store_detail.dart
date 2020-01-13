import 'package:flutter/material.dart';
import 'package:lottery/models/store.dart';
import 'package:lottery/widgets/rec.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/store.dart';

class StoreDetailScreen extends StatefulWidget {
  static const routeName = '/storeDetail';
  @override
  _StoreDetailScreenState createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
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
                              right: 25, left: 10, top: 10),
                          child: Image.asset(
                            'assets/images/store-icon.png',
                            height: 40,
                          ),
                        ),
                        Text(
                          'جزئیات فروشگاه',
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
                                          //Text(_currentTransaction.id.toString()),
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
                                          ), //Text(_currentTransaction.mallName),
                                          //Text(_currentTransaction.confirm.toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.all(10),
                                  //   child: Text(
                                  //     _currentTransaction.time +
                                  //         ' | ' +
                                  //         _currentTransaction.date,
                                  //     textAlign: TextAlign.left,
                                  //     style: TextStyle(fontSize: 14),
                                  //   ),
                                  // ),
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
    // Scaffold(
    //   appBar: AppBar(),
    //   body: _isLoading
    //       ? Center(
    //           child: CircularProgressIndicator(
    //             backgroundColor: Theme.of(context).primaryColor,
    //           ),
    //         )
    //       : Container(
    //           child: Center(
    //               child: Column(
    //             children: <Widget>[
    //               Text(_currentStore.id.toString()),
    //               Text(_currentStore.status),
    //               Text(_currentStore.logoUrl),
    //               Text(_currentStore.name),
    //               Text(_currentStore.type),
    //               Text(_currentStore.subType),
    //               Text(_currentStore.unitNumber),
    //               Text(_currentStore.phoneNumber),
    //               Text(_currentStore.faxNumber),
    //               Text(_currentStore.address),
    //             ],
    //           )),
    //         ),
    // );
  }
}
