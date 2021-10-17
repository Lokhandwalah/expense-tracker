import 'category.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}

List<Transaction> get transactionList {
  final DateTime current = DateTime.now();
  return [
    Transaction(
        id: 't1',
        title: 'New Shoes',
        amount: 800,
        date: current,
        category: Category.clothing),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: current,
      category: Category.food,
    ),
    Transaction(
      id: 't3',
      title: 'DTH Bill',
      amount: 2999,
      date: current.subtract(Duration(days: 1)),
      category: Category.bills,
    ),
    Transaction(
      id: 't4',
      title: 'New Batteries',
      amount: 99,
      date: current.subtract(Duration(days: 3)),
      category: Category.electronics,
    ),
    Transaction(
      id: 't5',
      title: 'Mobile Recharge',
      amount: 249,
      date: current.subtract(Duration(days: 1)),
      category: Category.bills,
    ),
    Transaction(
      id: 't6',
      title: 'Pizza Party',
      amount: 650,
      date: current.subtract(Duration(days: 3)),
      category: Category.food,
    ),
    Transaction(
        id: 't7',
        title: 'Coffee',
        amount: 49,
        date: current.subtract(Duration(days: 2)),
        category: Category.food),
    Transaction(
        id: 't8',
        title: 'Dinner',
        amount: 1099,
        date: current.subtract(Duration(days: 2)),
        category: Category.food),
    Transaction(
      id: 't9',
      title: 'Uber',
      amount: 700,
      date: current.subtract(Duration(days: 4)),
      category: Category.travel,
    ),
    Transaction(
      id: 't9',
      title: 'Bus',
      amount: 1700,
      date: current.subtract(Duration(days: 4)),
      category: Category.travel,
    ),
  ];
}
