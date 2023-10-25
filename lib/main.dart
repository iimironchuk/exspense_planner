import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/services.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import './theme/light_theme.dart';

void main(){
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //  DeviceOrientation.portraitUp, 
  //  DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Planner',
      theme: LightTheme.lightTheme(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget  {
    @override
    _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage>{
  late bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;

  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: 't1',
    //     title: 'New shoes',
    //     amount: 69.99,
    //     date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'Weekly grosiers',
    //     amount: 16.53,
    //     date: DateTime.now()),
  ];

  late bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTx(String txTitle, double txAmount, DateTime selectedDate){
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: selectedDate,
        id: DateTime.now().toString()
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder:(_) {
      return NewTransaction(_addNewTx);
      },
    );
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildPortraitContent(AppBar appBar, Widget txList){
    return [Container(
                height: (MediaQuery.of(context).size.height
                  - appBar.preferredSize.height
                  - MediaQuery.of(context).padding.top) * 0.3,
                child: Chart(_recentTransaction),
                ), txList];
  }

  List<Widget> _buildLandscapeContent(AppBar appBar, Widget txList){
    return [Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show chart'),
                Switch(value: _showChart, onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
                })
              ],
            ), _showChart
               ? Container(
                height: (MediaQuery.of(context).size.height
                  - appBar.preferredSize.height
                  - MediaQuery.of(context).padding.top) * 1,
                child: Chart(_recentTransaction),
              ) : txList];
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text('Planner', style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Colors.white,
        )
      ),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add))
      ],
    );
    final txList = Container(
      height: (MediaQuery.of(context).size.height
        - appBar.preferredSize.height
        - MediaQuery.of(context).padding.top) * 0.7,
      child: TransactionList(_userTransaction, _deleteTransaction),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if(isLandScape) ..._buildLandscapeContent(appBar, txList),
              if (!isLandScape) ..._buildPortraitContent(appBar, txList),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
