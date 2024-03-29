import 'dart:async';

import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewGetStarted extends StatelessWidget {
  const NewGetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.offAllNamed(AppLinks.events);
    });
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kFenwickBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 53.75,
            ),
            const SizedBox(
              height: 15,
            ),
            MyText(
              text: 'Welcome to\nFenwick’s Pub'.toUpperCase(),
              size: 30,
              weight: FontWeight.w700,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
