import 'dart:async';

import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/images.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.offAllNamed(AppLinks.events);
    });
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(kMainLogo),
        ],
      ),
    );
  }
}
