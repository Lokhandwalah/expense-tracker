import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/app_theme.dart';
import '../models/category.dart';
import 'custom_button.dart';

class NewTransaction extends StatefulWidget {
  final Function(String txTitle, double txAmount, DateTime chosenDate, Category)
      addTx;

  const NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController(text: '');
  final _amountController = TextEditingController(text: '');
  DateTime _selectedDate = DateTime.now();
  Category _selectedCategory = Category.others;

  void _submitData() {
    if (!_formKey.currentState!.validate()) return;

    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
      _selectedCategory,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please enter a title";
                    } else if (val.length < 3) {
                      return "Min length is 3";
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _submitData(),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (double.tryParse(val.toString()) == null) {
                      return "Please enter a valid amount";
                    } else if (double.tryParse(val.toString())! <= 0.0) {
                      return "Please enter a amount greate than 0";
                    }
                    return null;
                  },
                  // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onFieldSubmitted: (_) => _submitData(),
                ),
                SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Category: ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Wrap(
                      spacing: 4,
                      children: [
                        ...categories.map(
                          (category) => InkWell(
                            onTap: () => setState(() {
                              _selectedCategory = category;
                            }),
                            child: Chip(
                              avatar: Icon(
                                category.icon,
                                color: AppTheme.secondary,
                              ),
                              label: Text(category.name),
                              backgroundColor: _selectedCategory == category
                                  ? AppTheme.primary
                                  : AppTheme.offWhite,
                              side: _selectedCategory == category
                                  ? null
                                  : BorderSide(color: AppTheme.secondary),
                              labelStyle: TextStyle(
                                color: _selectedCategory == category
                                    ? AppTheme.white
                                    : AppTheme.secondary,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: RichText(
                      text: TextSpan(
                          text: 'Date: ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: DateFormat.yMd().format(_selectedDate),
                                style: TextStyle(color: AppTheme.primary))
                          ]),
                    )),
                    CustomButton('Choose Date', _presentDatePicker)
                  ],
                ),
                ElevatedButton(
                  child: Text('Add Transaction'),
                  onPressed: _submitData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
