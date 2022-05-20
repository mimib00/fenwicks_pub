import 'package:cached_network_image/cached_network_image.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/total_reward_points.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      final user = controller.user.value!;
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
                  GestureDetector(
                    onTap: () async {
                      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                      if (image == null) return;
                      controller.updateUserPhoto(image);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: CachedNetworkImage(
                        imageUrl: user.photo,
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                        errorWidget: (_, __, ___) => const CircleAvatar(
                          radius: 60,
                          child: Icon(
                            Icons.person_rounded,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                  MyText(
                    paddingTop: 20,
                    text: user.name,
                    size: 21,
                    weight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                ],
              ),
            ),
            Positioned(
              top: 280,
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
                      trailing: user.name,
                    ),
                    ProfileTiles(
                      leading: 'Email',
                      trailing: user.email,
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
                      child: totalRewardPoints(user.points),
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
            )
          ],
        ),
      );
    });
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
            text: '14 points rewarded on going on event\n"Event name will come here"',
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
