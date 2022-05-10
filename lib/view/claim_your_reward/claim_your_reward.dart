import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/drawer/my_drawer.dart';
import 'package:fenwicks_pub/view/widget/my_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/total_reward_points.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClaimYourReward extends StatelessWidget {
  const ClaimYourReward({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      haveNotificationIcon: true,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 250,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'assets/images/leafs.png',
                height: 241,
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              totalRewardPoints(
                114,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  MyText(
                    text: 'Hello',
                    size: 33,
                    fontFamily: 'Poppins',
                  ),
                  MyText(
                    text: ', Breth',
                    size: 33,
                    weight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ],
              ),
              MyText(
                text: '50 more point to claim a free drink!',
                size: 19,
                fontFamily: 'Poppins',
                paddingTop: 5,
                paddingBottom: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: Get.width * 0.8,
                  child: ContainerDecorations.customDivider,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: discount(
                      '20%',
                      5500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        freeDrinks(
                          '',
                          125,
                          kBlackColor,
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        freeDrinks(
                          '2',
                          125,
                          kSecondaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              CustomButton(
                onPressed: () => Get.dialog(
                  const ClaimsPopup(),
                ),
                text: 'Claim Your Reward Now',
                textSize: 20,
                weight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
              MyText(
                paddingTop: 25,
                paddingBottom: 20,
                height: 1.7,
                text:
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna',
                size: 14,
                fontFamily: 'Poppins',
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 15,
                    ),
                    height: 108,
                    padding: const EdgeInsets.fromLTRB(
                      5,
                      5,
                      15,
                      5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kSecondaryColor,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/new_glass.png',
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              MyText(
                                text: 'Reward Name Here',
                                size: 17,
                                weight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                              MyText(
                                text:
                                    'Lorem ipsum dolor sit amet, cons sadipscing elitr, sed diam',
                                size: 12,
                                weight: FontWeight.w300,
                                fontFamily: 'Poppins',
                              ),
                              Row(
                                children: [
                                  MyText(
                                    text: '2850',
                                    size: 18,
                                    weight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                    color: kPrimaryColor,
                                  ),
                                  Expanded(
                                    child: MyText(
                                      paddingLeft: 5,
                                      text: 'Points Required',
                                      size: 18,
                                      weight: FontWeight.w300,
                                      fontFamily: 'Poppins',
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget freeDrinks(
    String freeDrinks,
    int points,
    Color bgColor,
  ) {
    return Container(
      height: 145,
      width: Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/bg.png',
            ),
          ),
          MyText(
            text: 'Free $freeDrinks Drink',
            size: 11,
            weight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
          MyText(
            text: '$points Points',
            size: 12,
            fontFamily: 'Poppins',
          ),
        ],
      ),
    );
  }

  Widget discount(
    String discount,
    int points,
  ) {
    return Container(
      height: 302,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 3.0,
          color: kSecondaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MyText(
                  text: '*Rules and regulations applied*',
                  size: 8,
                  maxLines: 2,
                  overFlow: TextOverflow.ellipsis,
                  paddingBottom: 10,
                  fontFamily: 'Poppins',
                ),
              ),
              Image.asset(
                ContainerDecorations.circle,
                height: 35,
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/bg.png',
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: 'Fenwick’s Pub',
                size: 9,
                fontFamily: 'Poppins',
                color: kSecondaryColor,
              ),
              MyText(
                text: '$discount DISCOUNT',
                size: 21,
                fontFamily: 'Poppins',
              ),
              MyText(
                text: 'on $points points',
                size: 13,
                fontFamily: 'Poppins',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ClaimsPopup extends StatelessWidget {
  const ClaimsPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        height: Get.height * 0.65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: kWhiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyText(
              text: '"only to be used by the staff"',
              size: 16,
              align: TextAlign.center,
              weight: FontWeight.w500,
              fontFamily: 'Poppins',
              color: kSecondaryColor,
              paddingBottom: 6,
            ),
            MyText(
              text: "This user wants to claim free stuff!",
              size: 16,
              align: TextAlign.center,
              weight: FontWeight.w600,
              color: kPrimaryColor,
              fontFamily: 'Poppins',
              paddingBottom: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: Image.asset(kGiftCard),
              ),
            ),
            MyText(
              paddingTop: 10,
              text: "Verify below user's free claim",
              size: 16,
              align: TextAlign.center,
              weight: FontWeight.w600,
              color: kPrimaryColor,
              fontFamily: 'Poppins',
            ),
            Container(
              height: 58,
              margin: const EdgeInsets.fromLTRB(
                0,
                10,
                0,
                20,
              ),
              color: kGreyColor2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyText(
                    paddingLeft: 15,
                    text: 'x1 Beer',
                    size: 16,
                    weight: FontWeight.w500,
                    color: kPrimaryColor,
                    fontFamily: 'Poppins',
                  ),
                  Container(),
                  MyText(
                    text: '0\$',
                    size: 16,
                    paddingRight: 15,
                    weight: FontWeight.w700,
                    color: kPrimaryColor,
                    fontFamily: 'Poppins',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: CustomButton(
                onPressed: () {
                  Get.back();
                  Get.toNamed(AppLinks.verifyPassword);
                },
                text: 'Verify',
                textSize: 17,
                btnBgColor: kRedColor,
                weight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
