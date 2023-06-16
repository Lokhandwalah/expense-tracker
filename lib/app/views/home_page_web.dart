import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/utils/screen_config.dart';
import '../models/category.dart' as expense;
import '../models/transaction.dart';
import '../widgets/categories_chart.dart';
import '../widgets/categories_list.dart';
import '../widgets/chart.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({Key? key}) : super(key: key);

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  List<Transaction> _userTransactions = transactionList;

  expense.Category? _selectedCategory;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate,
      expense.Category category) {
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('Hello,', style: TextStyle(fontSize: 35)),
                    Text(
                      'Husain',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: kIsWeb
                          ? getScreenHeight(context) * .45
                          : getScreenHeight(context) * .55,
                      child: Chart(
                        _recentTransactions,
                        isWeb: true,
                      ),
                    ),
                    Container(
                      height: kIsWeb
                          ? getScreenHeight(context) * .55
                          : getScreenHeight(context) * .45,
                      child: CategoriesChart(transactions: _userTransactions),
                    )
                  ],
                ),
                Positioned(
                  top: 40,
                  right: 40,
                  child: TextButton.icon(
                    icon: Icon(Icons.add),
                    label: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
                ),
              ],
            )),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height:
                    getScreenHeight(context) + getScreenHeight(context) * .2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoryFilter(
                      selectedCategory: _selectedCategory,
                      onTap: (category) => setState(() => _selectedCategory =
                          _selectedCategory?.name == category?.name
                              ? null
                              : category),
                    ),
                    Expanded(child: txListWidget),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      body: pageBody,
    );
  }
}
