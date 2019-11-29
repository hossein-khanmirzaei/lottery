import 'package:flutter/material.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/screens/new_creditcard.dart';
import 'package:lottery/widgets/credit_card_list.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/creditcard.dart';

class CreditCardScreen extends StatefulWidget {
  static const routeName = '/cardList';
  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  var _isLoading = false;
  // List<CreditCard> _cards;

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

  Future<void> _getCradList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<CreditCardProvider>(context, listen: false)
          .getCardList();
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      // _cards = Provider.of<CreditCardProvider>(context, listen: false).cardList;
      _isLoading = false;
    });
  }

  // Future<void> _addCreditCard(String cardTitle, String cardNumber) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     await Provider.of<CreditCardProvider>(context, listen: false)
  //         .addCard(
  //       cardTitle,
  //       cardNumber,
  //     )
  //         .then((_) {
  //       Navigator.of(context).pop();
  //     });
  //   } on HttpException catch (error) {
  //     _showErrorDialog(error.toString());
  //   } catch (error) {
  //     _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
  //   }
  //   setState(() {
  //     cards = Provider.of<CreditCardProvider>(context).cardList;
  //     _isLoading = false;
  //   });
  // }

  @override
  void initState() {
    _getCradList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(NewCreditCardScreen.routeName);
        },
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : Consumer<CreditCardProvider>(
              builder: (ctx, creditCard, _) =>
                  CreditCardList(creditCard.cardList),
            ),
    );
  }
}
