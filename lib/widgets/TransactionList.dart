import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
 final Function deleteTx;
  TransactionList({this.userTransactions,this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: userTransactions.isEmpty
          ? Column(children: <Widget>[
              Text(
                "No Transactions Added yet",
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ])
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: userTransactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                      userTransactions[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(child: Text('₹${userTransactions[index].amount.toStringAsFixed(0)}'))),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(userTransactions[index].date),
                    ),
                    trailing: IconButton(icon: Icon(Icons.delete,color:Colors.redAccent),
                    onPressed: ()=>deleteTx(userTransactions[index].id),
                    ),
                  ),
                );
              }),
    );
  }
}
