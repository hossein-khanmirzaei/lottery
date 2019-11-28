import 'package:flutter/material.dart';
import 'package:lottery/models/creditcard.dart';

class CreditCardList extends StatelessWidget {
  final List<CreditCard> creditCards;
  final Function deleteCreditCard;

  CreditCardList(this.creditCards, this.deleteCreditCard);

  String _butifyCreditCardNumber(String cardNumber) {
    List<String> cardNumberList = cardNumber.split('').toList();
    cardNumberList.insert(4, ' - ');
    cardNumberList.insert(9, ' - ');
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
            : ListView.separated(
                itemCount: creditCards.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.edit),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteCreditCard(creditCards[index].id),
                    ),
                    title: Text(
                      creditCards[index].title,
                      style: Theme.of(context).textTheme.headline,
                    ),
                    subtitle: Text(                      
                      _butifyCreditCardNumber(creditCards[index].cardNumber),
                      style: Theme.of(context).textTheme.subhead,
                      textDirection: TextDirection.ltr,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
      ),
    );
  }
}
