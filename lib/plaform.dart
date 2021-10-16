import 'dart:io';
import 'package:flutter/foundation.dart';

class CurrentPlatForm {
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isWeb => kIsWeb;
}
