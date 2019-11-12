import 'package:flutter/material.dart';
import 'package:lottery/models/creditcard.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/providers/creditcards.dart';
import 'package:lottery/widgets/credit_card_list.dart';
import 'package:lottery/widgets/new_credit_card.dart';
import 'package:provider/provider.dart';

class CreditCardScreen extends StatefulWidget {
  static const routeName = '/cardList';
  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  var _isLoading = false;
  List<CreditCard> cards = [];

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('خطا!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
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
      print(error);
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      cards = Provider.of<CreditCardProvider>(context, listen: false).cardList;
      _isLoading = false;
    });
  }

  Future<void> _addCreditCard(String cardTitle, String cardNumber) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<CreditCardProvider>(context, listen: false)
          .addCard(
        cardTitle,
        cardNumber,
      )
          .then((_) {
        Navigator.of(context).pop();
      });
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('خطایی رخ داده است. لطفاً بعداً تلاش کنید.');
    }
    setState(() {
      cards = Provider.of<CreditCardProvider>(context, listen: false).cardList;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _getCradList();
    super.initState();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewCreditCard(_addCreditCard),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CreditCardList(cards, () {}),
    );
  }
}
