import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../core/app_theme.dart';
import '../../core/utils/screen_config.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  final SlidableController slidableController = SlidableController();
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    final todayTransactions = transactions
        .where((transaction) => isToday(transaction.date, DateTime.now()));
    return SingleChildScrollView(
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: getScreenHeight(context) * 0.25,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (todayTransactions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Today',
                      style: TextStyle(
                        color: AppTheme.secondary,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ...todayTransactions.map(
                  (transaction) => buildTransactionCard(
                    context,
                    transaction,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Recent',
                    style: TextStyle(
                      color: AppTheme.secondary,
                      fontSize: 18,
                    ),
                  ),
                ),
                ...transactions
                    .where((transaction) =>
                        !isToday(transaction.date, DateTime.now()))
                    .map(
                      (transaction) => buildTransactionCard(
                        context,
                        transaction,
                      ),
                    )
              ],
            ),
    );
  }

  Widget buildTransactionCard(BuildContext context, Transaction transaction) {
    final DateTime current = DateTime.now();
    bool isToday = current.day == transaction.date.day &&
        current.month == transaction.date.month &&
        current.year == transaction.date.year;
    bool isSameYear = DateTime.now().year == transaction.date.year;
    return Card(
      elevation: 5,
      child: Slidable(
        key: UniqueKey(),
        controller: slidableController,
        actionPane: SlidableScrollActionPane(),
        secondaryActions: [
          IconSlideAction(
            iconWidget: Icon(
              Icons.delete_outline,
              color: Colors.redAccent,
            ),
            caption: 'Delete',
            onTap: () => deleteTx(transaction.id),
          ),
        ],
        child: ListTile(
          leading: Card(
            elevation: 6,
            shape: CircleBorder(),
            color: AppTheme.offWhite,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                transaction.category.icon,
                color: AppTheme.primary,
              ),
            ),
          ),
          title: Text(
            transaction.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(transaction.category.name),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '₹' + NumberFormat("###,###.0#").format(transaction.amount),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 5),
              if (!isToday)
                Text(
                  DateFormat(isSameYear ? 'MMM d' : 'MMM d, yyyy')
                      .format(transaction.date),
                  style: TextStyle(
                    color: AppTheme.secondary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  bool isToday(DateTime a, DateTime b) =>
      a.day == b.day && a.month == b.month && a.year == b.year;
}
