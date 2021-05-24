import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static Future<InitializationStatus> initialize() {
    return MobileAds.instance.initialize();
  }

  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-7581095423661277~4383840596";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111"; // testId
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
