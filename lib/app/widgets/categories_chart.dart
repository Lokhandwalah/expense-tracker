import 'package:expense_tracker/app/models/category.dart';
import 'package:expense_tracker/app/models/transaction.dart';
import 'package:expense_tracker/core/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesChart extends StatefulWidget {
  final List<Transaction> transactions;
  const CategoriesChart({Key? key, required this.transactions})
      : super(key: key);

  @override
  _CategoriesChartState createState() => _CategoriesChartState();
}

class _CategoriesChartState extends State<CategoriesChart> {
  @override
  Widget build(BuildContext context) {
    final foodTransactions = widget.transactions
        .where((t) => t.category.name == Category.food.name)
        .toList();
    final clothingTransactions = widget.transactions
        .where((t) => t.category.name == Category.clothing.name)
        .toList();
    final billsTransactions = widget.transactions
        .where((t) => t.category.name == Category.bills.name)
        .toList();
    final electronicsTransactions = widget.transactions
        .where((t) => t.category.name == Category.electronics.name)
        .toList();
    final travelTransactions = widget.transactions
        .where((t) => t.category.name == Category.travel.name)
        .toList();
    final otherTransactions = widget.transactions
        .where((t) => t.category.name == Category.others.name)
        .toList();
    final totalAmount =
        widget.transactions.fold<double>(0, (sum, t) => sum + t.amount);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Expenses by category:",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: [
                buildCategoryTile(foodTransactions, Category.food, totalAmount),
                buildCategoryTile(
                    clothingTransactions, Category.clothing, totalAmount),
                buildCategoryTile(
                    billsTransactions, Category.bills, totalAmount),
                buildCategoryTile(
                    electronicsTransactions, Category.electronics, totalAmount),
                buildCategoryTile(
                    travelTransactions, Category.travel, totalAmount),
                buildCategoryTile(
                    otherTransactions, Category.others, totalAmount),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryTile(
      List<Transaction> transactions, Category category, double totalAmount) {
    final totalCategoryAmount =
        transactions.fold<double>(0, (sum, t) => sum + t.amount);
    return Card(
      child: ListTile(
        leading: Card(
          elevation: 10,
          shape: CircleBorder(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              category.icon,
            ),
          ),
        ),
        title: Text(category.name),
        subtitle: Text(
          '₹' + totalCategoryAmount.toString(),
          style: TextStyle(color: AppTheme.secondary, fontSize: 20),
        ),
        trailing: Text(
          (totalCategoryAmount / totalAmount * 100).toStringAsFixed(2) + '%',
          style: TextStyle(color: AppTheme.primary, fontSize: 20),
        ),
      ),
    );
  }
}
