import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/transaction.dart';
import '../widgets/chart.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';

class HomePageMobileAndroid extends StatefulWidget {
  const HomePageMobileAndroid({Key? key}) : super(key: key);

  @override
  State<HomePageMobileAndroid> createState() => _HomePageMobileAndroidState();
}

class _HomePageMobileAndroidState extends State<HomePageMobileAndroid> {
  final List<Transaction> _userTransactions = transactionList;

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate, Category category) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
      category: category,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBarHeight = AppBar().preferredSize.height;
    final txListWidget = SizedBox(
      height: (mediaQuery.size.height - appBarHeight - mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = OrientationBuilder(
      builder: (context, orientation) {
        final isLandscape = orientation == Orientation.landscape;
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (isLandscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Show Chart',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Switch.adaptive(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = val;
                          });
                        },
                      ),
                    ],
                  ),
                if (!isLandscape) Chart(_recentTransactions),
                if (!isLandscape) txListWidget,
                if (isLandscape)
                  _showChart
                      ? Container(
                          height: (mediaQuery.size.height -
                                  appBarHeight -
                                  mediaQuery.padding.top) *
                              0.7,
                          child: Chart(_recentTransactions),
                        )
                      : txListWidget
              ],
            ),
          ),
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
