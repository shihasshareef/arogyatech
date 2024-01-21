import 'package:flutter/foundation.dart';

class ArogyaEnvironment {
  static String devUrl = 'https://oh5oe1gr6i.execute-api.ap-south-1.amazonaws.com/dev/admin/';
  static String prodUrl = 'https://oh5oe1gr6i.execute-api.ap-south-1.amazonaws.com/prod/admin/';
  static String serverUrl = '';
  static String appVersion = '1.0.0';

  setEnvironment() {
    if (kDebugMode) {
      print('debug mode');
      serverUrl = devUrl;
    } else {
      if (kDebugMode) {
        print('release mode');
      }
      serverUrl = prodUrl;
    }
  }
}
