import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottery/models/http_exception.dart';
import 'package:lottery/screens/new_creditcard.dart';
import 'package:lottery/widgets/credit_card_list.dart';
import 'package:lottery/widgets/rec.dart';
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
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purpleAccent,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(NewCreditCardScreen.routeName);
            },
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
                            FontAwesomeIcons.creditCard,
                            color: Colors.deepPurple,
                            size: 36,
                          ),
                        ),
                        Text(
                          'کارت ها',
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
                          : Consumer<CreditCardProvider>(
                              builder: (ctx, creditCard, _) => Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: CreditCardList(creditCard.cardList),
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
