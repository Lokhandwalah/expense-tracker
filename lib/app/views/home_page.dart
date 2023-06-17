import 'package:flutter/material.dart';

import '../../core/responsive_view.dart';
import 'home_page_android.dart';
import 'home_page_ios.dart';
import 'home_page_web.dart';

class MyHomePage extends View {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends ResponsiveViewSate<MyHomePage> {
  @override
  Widget get androidView => HomePageMobileAndroid();

  @override
  Widget get iosView => HomePageMobileIOS();

  @override
  Widget get webView => HomePageWeb();
}
