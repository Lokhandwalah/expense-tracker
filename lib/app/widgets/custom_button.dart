import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../plaform.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() handler;

  const CustomButton(this.text, this.handler, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurrentPlatForm.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : TextButton(
            onPressed: handler,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
  }
}
