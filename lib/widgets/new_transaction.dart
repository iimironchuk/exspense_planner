import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void submitData() {
    if(_amountController.text.isEmpty){
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    // ignore: unnecessary_null_comparison
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate); // Use widget.addTx here
    Navigator.of(context).pop(); // Close the modal bottom sheet
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  );
}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            left: 10, 
            right: 10, 
            top: 10, 
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          // ignore: unnecessary_null_comparison
                          _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}',
                        ),
                      ),
                      TextButton(
                        onPressed: _datePicker,
                        child: Text('Choose Date',
                          style: TextStyle(color: Theme.of(context).primaryColor)
                        )
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                  onPressed: submitData,
                  child: Text('Add Transaction'),
                ),
              ],
            ),
          ),
        ),
      ),
    ); 
  }
}
