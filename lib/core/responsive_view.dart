import 'package:flutter/material.dart';
import '../plaform.dart';

abstract class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);
}

abstract class ResponsiveViewSate<Page extends View> extends State<Page> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return size.width < size.height
        ? CurrentPlatForm.isIOS
            ? iosView
            : androidView
        : webView;
  }

  Widget get webView;
  Widget get iosView;
  Widget get androidView;
}
