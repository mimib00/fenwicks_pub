import 'package:cached_network_image/cached_network_image.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/discover/post_details.dart';
import 'package:fenwicks_pub/view/drawer/my_drawer.dart';
import 'package:fenwicks_pub/view/profile/discover_profile.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Discover extends StatelessWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            children: [
              discoverHeader(),
              const SizedBox(
                height: 15,
              ),
              // SizedBox(
              //   height: 50,
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: 5,
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 5,
              //     ),
              //     physics: const BouncingScrollPhysics(),
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       return discoverPeoples(
              //         kDummyUser,
              //         'James Bruno',
              //       );
              //     },
              //   ),
              // ),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Post(
                    profileImage: kDummyUser,
                    name: 'Michael Bruno',
                    hashTag: 'emmastone',
                    postImage: index.isOdd ? 'assets/images/32.png' : 'assets/images/Group 23.png',
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            right: 15,
            child: floatingActionButton(
              () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget discoverHeader() {
    return GetBuilder<AuthController>(builder: (controller) {
      final user = controller.user.value!;
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText(
                  text: 'Discover',
                  paddingRight: 15,
                  paddingBottom: 6,
                  size: 33,
                  weight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
                Image.asset(
                  kCircle,
                  height: 14,
                ),
              ],
            ),
            GestureDetector(
              onTap: () => Get.to(
                () => const DiscoverProfile(),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: CachedNetworkImage(
                  imageUrl: user.photo,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 50,
                  errorWidget: (_, __, ___) => const CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget floatingActionButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 60.35,
        width: 60.35,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kBlackColor.withOpacity(0.83),
              offset: const Offset(0, 7),
              blurRadius: 30,
            ),
          ],
          borderRadius: BorderRadius.circular(100),
          color: kWhiteColor.withOpacity(0.14),
        ),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: kBlackColor,
          ),
          child: Center(
            child: Image.asset(
              kAddIcon,
              height: 22,
            ),
          ),
        ),
      ),
    );
  }

  Widget discoverPeoples(String profileImage, name) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
      ),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: kSecondaryColor,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                profileImage,
                height: Get.height,
              ),
            ),
          ),
          MyText(
            paddingLeft: 10,
            text: name,
            size: 10,
            color: kWhiteColor.withOpacity(0.8),
            fontFamily: 'Poppins',
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Post extends StatelessWidget {
  Post({
    Key? key,
    this.profileImage,
    this.name,
    this.hashTag,
    this.postImage,
  }) : super(key: key);

  String? profileImage, name, hashTag, postImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 30,
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                profileImage!,
                height: 52,
                fit: BoxFit.cover,
              ),
            ),
            title: MyText(
              text: name,
              size: 16,
              weight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            subtitle: MyText(
              text: '@$hashTag',
              size: 11,
              color: kGreyColor3,
              fontFamily: 'Poppins',
            ),
            trailing: const Icon(
              Icons.more_vert,
              color: kSecondaryColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => Get.to(
              () => const PostDetails(),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                postImage!,
                height: 196,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          likeCommentShare(),
        ],
      ),
    );
  }

  Padding likeCommentShare() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Row(
        children: [
          Row(
            children: [
              Image.asset(
                kLike,
                height: 19.79,
              ),
              MyText(
                text: '247',
                size: 12,
                paddingLeft: 5,
                paddingBottom: 5,
                color: kSecondaryColor,
                weight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
            ),
            child: Row(
              children: [
                Image.asset(
                  kComment,
                  height: 19.95,
                ),
                MyText(
                  text: '57',
                  size: 12,
                  paddingLeft: 5,
                  paddingBottom: 5,
                  color: kSecondaryColor,
                  weight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ],
            ),
          ),
          Row(
            children: [
              Image.asset(
                kShare,
                height: 19.64,
              ),
              MyText(
                text: '33',
                size: 12,
                paddingLeft: 5,
                paddingBottom: 5,
                color: kSecondaryColor,
                weight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
