import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../../core/app_theme.dart';
import '../models/expense.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  final bool isWeb;

  const Chart(this.recentTransactions, {Key? key, this.isWeb = false})
      : super(key: key);

  List<Expense> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return Expense(
        date: DateFormat.E().format(weekDay).substring(0, 1),
        amount: totalSum,
      );
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + double.parse(item.amount.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount = 0;
    groupedTransactionValues.forEach((data) => totalAmount += data.amount);
    return Card(
      elevation: 6,
      color: AppTheme.primaryDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total:',
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.white,
              ),
            ),
            RichText(
              text: TextSpan(
                text: '₹ ',
                style: TextStyle(
                  fontSize: 18,
                  color: AppTheme.white,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: NumberFormat("###,###.0#").format(totalAmount),
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: groupedTransactionValues.map((data) {
                    return ChartBar(
                      data.date,
                      data.amount,
                      totalSpending == 0.0 ? 0.0 : data.amount / totalSpending,
                      isWeb: isWeb,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
