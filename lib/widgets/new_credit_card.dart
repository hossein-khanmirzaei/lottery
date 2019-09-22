import 'package:flutter/material.dart';

class NewCreditCard extends StatefulWidget {
  final Function addCreditCard;

  NewCreditCard(this.addCreditCard);

  @override
  _NewCreditCardState createState() => _NewCreditCardState();
}

class _NewCreditCardState extends State<NewCreditCard> {
  final _titleController = TextEditingController();
  final _cardNumberController = TextEditingController();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredCardNumber = _cardNumberController.text;

    if (enteredTitle.isEmpty || enteredCardNumber.isEmpty) {
      return;
    }
    widget.addCreditCard(
      enteredTitle,
      enteredCardNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        //height: MediaQuery.of(context).size.height * .4,
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'عنوان کارت'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'شماره کارت'),
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            RaisedButton(
              child: Text('ثبت'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
