import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:planyapp/src/providers/task_provider.dart';
import 'package:planyapp/src/services/admob_service.dart';
import 'package:provider/provider.dart';

class AdMobBanner extends StatefulWidget {
  @override
  _AdMobBannerState createState() => _AdMobBannerState();
}

class _AdMobBannerState extends State<AdMobBanner> {
  late BannerAd _banner;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _banner = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(onAdLoaded: (_) {
        setState(() {
          _isLoaded = true;
        });
      }),
    )..load();
  }

  @override
  void dispose() async {
    super.dispose();
    await _banner.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    taskProvider.initBannerIsLoaded(_isLoaded);

    if (_isLoaded) {
      return Container(child: AdWidget(ad: _banner), height: 50.0);
    }
    return Container(height: 0.0);
  }
}
