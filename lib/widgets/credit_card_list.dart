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
                    // leading: CircleAvatar(
                    //   radius: 30,
                    //   child: Padding(
                    //     padding: EdgeInsets.all(6),
                    //     child: null,
                    //   ),
                    // ),
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
                    // trailing: IconButton(
                    //   icon: Icon(Icons.edit),
                    //   color: Theme.of(context).errorColor,
                    //   onPressed: () =>
                    //       deleteCreditCard(creditCards[index].id),
                    // ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },

/*
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      // leading: CircleAvatar(
                      //   radius: 30,
                      //   child: Padding(
                      //     padding: EdgeInsets.all(6),
                      //     child: null,
                      //   ),
                      // ),
                      leading: IconButton(
                        icon: Icon(Icons.edit),
                        color: Theme.of(context).errorColor,
                        onPressed: () =>
                            deleteCreditCard(creditCards[index].id),
                      ),
                      title: Text(
                        creditCards[index].title,
                        //style: Theme.of(context).textTheme.subhead,
                      ),
                      subtitle: Text(
                        creditCards[index].cardNumber,
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(Icons.edit),
                      //   color: Theme.of(context).errorColor,
                      //   onPressed: () =>
                      //       deleteCreditCard(creditCards[index].id),
                      // ),
                    ),
                  );
                },
                itemCount: creditCards.length,
              ),
*/
              ),
      ),
    );
  }
}
