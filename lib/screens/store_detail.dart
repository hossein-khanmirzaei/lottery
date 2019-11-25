import 'package:flutter/material.dart';
import 'package:lottery/models/store.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : Container(
              child: Center(
                  child: Column(
                children: <Widget>[
                  Text(_currentStore.id.toString()),
                  Text(_currentStore.status),
                  Text(_currentStore.logoUrl),
                  Text(_currentStore.name),
                  Text(_currentStore.type),
                  Text(_currentStore.subType),
                  Text(_currentStore.unitNumber),
                  Text(_currentStore.phoneNumber),
                  Text(_currentStore.faxNumber),
                  Text(_currentStore.address),
                ],
              )),
            ),
    );
  }
}
