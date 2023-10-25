import 'package:courses_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTx;

  const TransactionItem({super.key, required this.transaction, required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 6,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 6),
              child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text('\$${transaction.amount}'),
                  ),
                ),
              ),
              title: Text(
                transaction.title,
                style: Theme.of(context).textTheme.titleMedium,),
              subtitle: Text(
                  DateFormat.yMMMd().format(transaction.date)
              ),
              trailing: MediaQuery.of(context).size.width > 460 ? 
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Theme.of(context).errorColor),
                onPressed: () => deleteTx(transaction.id), 
                icon: Icon(Icons.delete), 
                label: Text('Delete')) 
              : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteTx(transaction.id),
                color: Theme.of(context).errorColor,
              ),
            ),
          );
  }
}