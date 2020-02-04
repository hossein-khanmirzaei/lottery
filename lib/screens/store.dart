import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/store.dart';
import 'package:lottery/screens/store_detail.dart';
import 'package:lottery/widgets/rec.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/store.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  List<Store> _stores = [];
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

  Future<void> _getStoreList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<StoreProvider>(context, listen: false).fetchStores();
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      _stores = Provider.of<StoreProvider>(context, listen: false).storeList;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getStoreList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    'فروشگاه',
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
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: ListView.builder(
                          itemCount: _stores.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Provider.of<StoreProvider>(context,
                                        listen: false)
                                    .setCurrentStore(_stores[index].id);
                                Navigator.of(context)
                                    .pushNamed(StoreDetailScreen.routeName);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 12,
                                    right:
                                        MediaQuery.of(context).size.width / 12,
                                    top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                _stores[index].name,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                'شماره واحد ' +
                                                    _stores[index]
                                                        .unitNumber
                                                        .toString(),
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // child: IconButton(
                                      //   icon: Icon(Icons.search),
                                      //   color: Theme.of(context).errorColor,
                                      //   onPressed: () {
                                      //     Provider.of<StoreProvider>(context,
                                      //             listen: false)
                                      //         .setCurrentStore(
                                      //             _stores[index].id);
                                      //     Navigator.of(context).pushNamed(
                                      //         StoreDetailScreen.routeName);
                                      //   },
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // ListView.separated(
                        //     itemCount: _stores.length,
                        //     itemBuilder: (context, index) {
                        //       return ListTile(
                        //         title: Text(
                        //           _stores[index].name.toString(),
                        //           style: Theme.of(context).textTheme.title,
                        //         ),
                        //         subtitle: Text(
                        //           _stores[index].unitNumber,
                        //         ),
                        //         trailing: IconButton(
                        //           icon: Icon(Icons.search),
                        //           color: Theme.of(context).errorColor,
                        //           onPressed: () {
                        //             Provider.of<StoreProvider>(context,
                        //                     listen: false)
                        //                 .setCurrentStore(_stores[index].id);
                        //             Navigator.of(context)
                        //                 .pushNamed(StoreDetailScreen.routeName);
                        //           },
                        //         ),
                        //       );
                        //     },
                        //     separatorBuilder: (context, index) {
                        //       return Divider();
                        //     },
                        //   ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
