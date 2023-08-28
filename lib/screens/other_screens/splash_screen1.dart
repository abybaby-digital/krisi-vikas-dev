import 'dart:async';
import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/account/login_screen.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {
        if (mounted == true) {
          gotoWithoutBack(
            context,
            LoginScreen(),
          );
        }
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
          AppImages.splashImage1,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
