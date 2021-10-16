import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function() handler;

  const AdaptiveFlatButton(this.text, this.handler, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Platform.isIOS
        //     ? CupertinoButton(
        //         child: Text(
        //           text,
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //         onPressed: handler,
        //       )
        //     :
        TextButton(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onPressed: handler,
    );
  }
}
