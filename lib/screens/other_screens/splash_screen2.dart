import 'dart:async';
import 'package:flutter/material.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../home/home_screen.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  void initState() {
    getUserCurrentLocation();
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        gotoWithoutBack(
          context,
          HomeScreen(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // dynamicLinkService.handleDynamicLinks(context);
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          AppImages.splashImage2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
