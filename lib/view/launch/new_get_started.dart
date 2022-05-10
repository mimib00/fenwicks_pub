import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewGetStarted extends StatelessWidget {
  const NewGetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            MyText(
              paddingTop: 20,
              paddingBottom: 30,
              text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et',
              size: 16,
              weight: FontWeight.w600,
              fontFamily: 'Open Sans',
              height: 1.6,
            ),
            GestureDetector(
              onTap: () => Get.offAllNamed(AppLinks.auth),
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  MyText(
                    paddingRight: 10,
                    text: 'Continue',
                    size: 16,
                    weight: FontWeight.w700,
                  ),
                  Image.asset(
                    kArrowForwardBold,
                    height: 15.77,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
