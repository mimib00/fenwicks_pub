import 'package:fenwicks_pub/controller/profile_controller/discover_profile_controller.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class DiscoverProfile extends StatelessWidget {
  const DiscoverProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscoverProfileController>(
      init: DiscoverProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: backButton(),
          ),
          body: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileCard(
                profileImage: kDummyUser,
                name: 'David Bruno',
                address: 'San Francisco, CA',
                bio:
                    'Rhoncus ipsum eget tempus. Praesent fermentum sa  rhoncus.',
              ),
              const SizedBox(
                height: 60,
              ),
              StaggeredGridView.countBuilder(
                shrinkWrap: true,
                crossAxisCount: 3,
                physics: const BouncingScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemCount: controller.getDummyImages.length,
                staggeredTileBuilder: (int index) {
                  return StaggeredTile.count(
                    index == 4 ? 2 : 1,
                    index == 4 ? 2.3 : 1.0,
                  );
                },
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    controller.getDummyImages[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class ProfileCard extends StatelessWidget {
  ProfileCard({
    Key? key,
    this.profileImage,
    this.name,
    this.address,
    this.bio,
  }) : super(key: key);
  String? profileImage, name, address, bio;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: kWhiteColor,
                  width: 4,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  profileImage!,
                  height: Get.height,
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              left: 0,
              right: 0,
              child: Align(
                child: SizedBox(
                  width: 88,
                  child: MaterialButton(
                    height: 25,
                    onPressed: () {},
                    shape: const StadiumBorder(),
                    color: kSecondaryColor,
                    elevation: 0,
                    highlightElevation: 0,
                    child: MyText(
                      text: 'Edit Profile',
                      size: 10,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyText(
                text: '$name',
                size: 21,
                weight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
              MyText(
                text: '$address',
                size: 14,
                color: kSecondaryColor,
                fontFamily: 'Poppins',
                paddingBottom: 7,
              ),
              MyText(
                text: '$bio',
                size: 10,
                color: kWhiteColor.withOpacity(0.78),
                fontFamily: 'Poppins',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
