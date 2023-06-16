import 'package:flutter/material.dart';
import 'app/views/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: ThemeData.light()
              .colorScheme
              .copyWith(primary: Colors.purple, secondary: Colors.amber)),
      home: MyHomePage(),
    );
  }
}
