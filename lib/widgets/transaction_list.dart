import 'package:courses_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:courses_planner/models/transaction.dart';
// ignore: unused_import
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty ? LayoutBuilder(builder: ((context, constraints) {
      return Column(
        children: [
          Text('No transaction added yet',
          style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 25,),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover),
          )
        ],
      );
    })) 
          : ListView.builder(
          itemBuilder: (ctx, index){
            return TransactionItem(transaction: transaction[index], deleteTx: deleteTx);
        },
      itemCount: transaction.length,
    );
  }
}
