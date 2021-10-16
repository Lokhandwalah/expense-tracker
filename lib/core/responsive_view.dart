import 'package:flutter/material.dart';
import '../plaform.dart';

abstract class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);
}

abstract class ResponsiveViewSate<Page extends View> extends State<Page > {
  @override
  Widget build(BuildContext context) {
    return CurrentPlatForm.isWeb
        ? webView
        : CurrentPlatForm.isIOS
            ? iosView
            : androidView;
  }

  Widget get webView;
  Widget get iosView;
  Widget get androidView;
}
