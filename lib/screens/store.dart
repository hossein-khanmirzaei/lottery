import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/models/store.dart';
import 'package:lottery/screens/store_detail.dart';
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
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          )
        : ListView.separated(
            itemCount: _stores.length,
            itemBuilder: (context, index) {
              return ListTile(
                // leading: CircleAvatar(
                //   radius: 30,
                //   child: Padding(
                //     padding: EdgeInsets.all(6),
                //     child: FittedBox(
                //       child: Text('\$${_transactions[index].originalAmount}'),
                //     ),
                //   ),
                // ),
                title: Text(
                  _stores[index].name.toString(),
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  _stores[index].unitNumber,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.search),
                  color: Theme.of(context).errorColor,
                  onPressed: () {
                    Provider.of<StoreProvider>(context, listen: false)
                        .setCurrentStore(_stores[index].id);
                    Navigator.of(context)
                        .pushNamed(StoreDetailScreen.routeName);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
  }
}
