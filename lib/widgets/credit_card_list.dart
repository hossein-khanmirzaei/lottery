import 'package:flutter/material.dart';
import 'package:lottery/models/creditcard.dart';
import 'package:lottery/screens/edit_creditcard.dart';
import 'package:provider/provider.dart';
import 'package:lottery/providers/creditcard.dart';

class CreditCardList extends StatelessWidget {
  final List<CreditCard> creditCards;
  //final Function deleteCreditCard;

  CreditCardList(this.creditCards);

  String _butifyCreditCardNumber(String cardNumber) {
    List<String> cardNumberList = cardNumber.split('').toList();
    cardNumberList.insert(4, ' - ');
    cardNumberList.replaceRange(5, 9, ['*', '*', '*', '*']);
    cardNumberList.insert(9, ' - ');
    cardNumberList.replaceRange(10, 12, ['*', '* ']);
    cardNumberList.insert(14, ' - ');
    return cardNumberList.fold('', (prev, element) => prev + element);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 500,
      child: Center(
        child: creditCards.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'کارتی ثبت نشده است!',
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              )
            : ListView.builder(
                itemCount: creditCards.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Provider.of<CreditCardProvider>(context)
                          .setCurrentCard(creditCards[index].id);
                      Navigator.of(context)
                          .pushNamed(EditCreditCardScreen.routeName);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 12,
                          right: MediaQuery.of(context).size.width / 12,
                          top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      creditCards[index].title,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      _butifyCreditCardNumber(
                                          creditCards[index].cardNumber),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //       //color: Colors.amber,
                          //       ),
                          //   child: IconButton(
                          //     icon: Icon(Icons.edit),
                          //     color: Theme.of(context).errorColor,
                          //     onPressed: () {
                          //       Provider.of<CreditCardProvider>(context)
                          //           .setCurrentCard(creditCards[index].id);
                          //       Navigator.of(context)
                          //           .pushNamed(EditCreditCardScreen.routeName);
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),

        // : ListView.separated(
        //     itemCount: creditCards.length,
        //     itemBuilder: (ctx, index) {
        //       return ListTile(
        //         leading: IconButton(
        //             icon: Icon(Icons.edit),
        //             color: Theme.of(context).errorColor,
        //             onPressed: () {
        //               Provider.of<CreditCardProvider>(context)
        //                   .setCurrentCard(creditCards[index].id);
        //               Navigator.of(context)
        //                   .pushNamed(EditCreditCardScreen.routeName);
        //             }),
        //         title: Text(
        //           creditCards[index].title,
        //           style: Theme.of(context).textTheme.headline,
        //         ),
        //         subtitle: Text(
        //           _butifyCreditCardNumber(creditCards[index].cardNumber),
        //           style: Theme.of(context).textTheme.subhead,
        //           textDirection: TextDirection.ltr,
        //         ),
        //       );
        //     },
        //     separatorBuilder: (context, index) {
        //       return Divider();
        //     },
        // ),
      ),
    );
  }
}
