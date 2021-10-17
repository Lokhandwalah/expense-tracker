import 'package:expense_tracker/core/utils/screen_config.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/transaction.dart';
import '../widgets/categories_list.dart';
import '../widgets/chart.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';

class HomePageMobile extends StatefulWidget {
  const HomePageMobile({Key? key}) : super(key: key);

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  List<Transaction> _userTransactions = transactionList;

  Category? _selectedCategory;

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
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
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
    _userTransactions.sort((a, b) => a.date.compareTo(b.date));
    _userTransactions = _userTransactions.reversed.toList();
    final txListWidget = TransactionList(
        _userTransactions
            .where(
              (transaction) => _selectedCategory != null
                  ? transaction.category.name == _selectedCategory?.name
                  : true,
            )
            .toList(),
        _deleteTransaction);
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10),
            Text('Hello,', style: TextStyle(fontSize: 35)),
            Text('Husain',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                )),
            Chart(_recentTransactions),
            CategoryFilter(
              selectedCategory: _selectedCategory,
              onTap: (category) => setState(() => _selectedCategory =
                  _selectedCategory?.name == category?.name ? null : category),
            ),
            Container(
              height: getScreenHeight(context) * 0.7,
              child: txListWidget,
            )
          ],
        ),
      ),
    );

    return Scaffold(
      body: pageBody,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 20.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
