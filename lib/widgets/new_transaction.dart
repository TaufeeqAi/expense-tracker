import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController expenseController = TextEditingController();

  final TextEditingController amountController = TextEditingController();
  DateTime selectedDate;
 
  void submitData() {
    if(amountController.text.isEmpty ){
      return;
    }
    final enteredTitle = expenseController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate== null){
      return;
    }
    widget.addTx(
      tx: enteredTitle,
      txAmount: enteredAmount,
      choosenDate:selectedDate,
    );
    Navigator.pop(context);
  }

  void chooseDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            onSubmitted: (_) => submitData(),
            controller: expenseController,
            decoration: InputDecoration(
                labelText: 'Expense', hintText: 'what you have spend for'),
          ),
          TextField(
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitData(),
            controller: amountController,
            decoration: InputDecoration(
                labelText: 'amount', hintText: 'enter the amount spend'),
          ),
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(selectedDate == null
                    ? 'Date not Choosen'
                    : "Picked Date: ${DateFormat.yMd().format(selectedDate)}"),
                FlatButton(
                  onPressed: chooseDate,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () => submitData()),
        ],
      ),
    );
  }
}
