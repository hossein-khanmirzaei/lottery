import 'package:flutter/material.dart';
import 'package:lottery/models/credit_card.dart';

class CreditCardList extends StatelessWidget {
  final List<CreditCard> creditCards;
  final Function deleteCreditCard;

  CreditCardList(this.creditCards, this.deleteCreditCard);

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
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: null,
                        ),
                      ),
                      title: Text(
                        creditCards[index].title,
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      subtitle: Text(
                        creditCards[index].cardNumber,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        color: Theme.of(context).errorColor,
                        onPressed: () =>
                            deleteCreditCard(creditCards[index].id),
                      ),
                    ),
                  );
                },
                itemCount: creditCards.length,
              ),
      ),
    );
  }
}
