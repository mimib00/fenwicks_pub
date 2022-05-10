import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/total_reward_points.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.only(
              top: 35,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(kBlurEffect),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Image.asset(
                          kArrowBack,
                          color: kWhiteColor,
                          height: 14.25,
                        ),
                      ),
                    ],
                  ),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          kNotificationIcon,
                          height: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          kMenuIcon,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 93,
                  width: 93,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: kBlackColor.withOpacity(0.16),
                        offset: const Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(100),
                    image: const DecorationImage(
                      image: AssetImage(
                        kDummyUser,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                MyText(
                  paddingTop: 20,
                  text: 'Elizabeth Nicks',
                  size: 21,
                  weight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ],
            ),
          ),
          Positioned(
            top: 270,
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kClippedEffect),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  ProfileTiles(
                    leading: 'Name',
                    trailing: 'Elizabeth Nicks',
                  ),
                  ProfileTiles(
                    leading: 'Email',
                    trailing: 'Email@gmail.com',
                  ),
                  ProfileTiles(
                    leading: 'Password',
                    trailing: '*********',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: 'Reward History',
                          size: 16,
                          weight: FontWeight.w700,
                        ),
                        MyText(
                          text: 'View All',
                          size: 11,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: totalRewardPoints(114),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 15,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    itemBuilder: (context, index) {
                      return const PRewardHistoryTiles();
                    },
                  ),
                  const SizedBox(
                    height: 250,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// ignore: must_be_immutable
class ProfileTiles extends StatelessWidget {
  ProfileTiles({
    Key? key,
    this.leading,
    this.trailing,
  }) : super(key: key);
  String? leading, trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
        left: 15,
        right: 15,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: '$leading',
                size: 11,
                fontFamily: 'Poppins',
              ),
              MyText(
                text: '$trailing',
                size: 16,
                weight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 15,
            ),
            height: 2,
            decoration: BoxDecoration(
              color: kWhiteColor.withOpacity(0.42),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
    );
  }
}

class PRewardHistoryTiles extends StatelessWidget {
  const PRewardHistoryTiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
        left: 15,
        right: 15,
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          minLeadingWidth: 25,
          onTap: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          tileColor: kBlackColor,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kCoin3,
                height: 25.84,
              ),
            ],
          ),
          title: MyText(
            paddingBottom: 7,
            text: 'Total Reward : 14 Points',
            size: 17,
            weight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
          subtitle: MyText(
            text:
            '14 points rewarded on going on event\n"Event name will come here"',
            size: 11,
            maxLines: 2,
            overFlow: TextOverflow.ellipsis,
            fontFamily: 'Poppins',
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MyText(
                height: 1.1,
                text: '14',
                size: 37,
                color: kSecondaryColor,
                weight: FontWeight.w900,
                fontFamily: 'Poppins',
              ),
              MyText(
                text: 'May, 2022',
                size: 9,
                color: kSecondaryColor,
                weight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
            ],
          ),
        ),
      ),
    );
  }
}