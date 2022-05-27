import 'package:fenwicks_pub/view/claim_your_reward/claim_your_reward.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_text.dart';

Widget totalRewardPoints(int points) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      GestureDetector(
        onTap: () => Get.to(
          () => const ClaimYourReward(),
        ),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: MyText(
              text: 'Total Reward : $points Points',
              size: 17,
              weight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      Positioned(
        top: -15,
        left: -10,
        child: Image.asset(
          kCoin1,
          height: 55.64,
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 15, top: 10),
          child: Image.asset(
            kCoin2,
            height: 22.84,
          ),
        ),
      ),
    ],
  );
}
