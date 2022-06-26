import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/custom_app_bar.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyDrawer extends StatefulWidget {
  MyDrawer({
    Key? key,
    this.child,
    this.haveNotificationIcon = false,
  }) : super(key: key);

  Widget? child;
  bool? haveNotificationIcon;

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with SingleTickerProviderStateMixin {
  late FancyDrawerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FancyDrawerController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FancyDrawerWrapper(
        cornerRadius: 30.0,
        itemGap: 55,
        drawerPadding: EdgeInsets.zero,
        backgroundColor: kBlackColor,
        controller: _controller,
        drawerItems: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  kDrawerInsideLogo,
                  height: 80.61,
                ),
                GetBuilder<AuthController>(
                  builder: (controller) {
                    final user = controller.user.value!;
                    final name = user.name.split(" ")[0];
                    return MyText(
                      paddingTop: 15,
                      text: 'Hey $name!',
                      weight: FontWeight.w700,
                      size: 25,
                    );
                  },
                ),
              ],
            ),
          ),
          Column(
            children: [
              DrawerTiles(
                title: 'Fenwick’s Events',
                onTap: () => Get.toNamed(AppLinks.events),
              ),
              DrawerTiles(
                title: 'Rewards',
                onTap: () => Get.toNamed(AppLinks.rewardHistory),
              ),
              DrawerTiles(
                title: 'Community',
                onTap: () => Get.toNamed(AppLinks.discover),
              ),
              DrawerTiles(
                title: 'Shop',
                onTap: () => Get.toNamed(
                  AppLinks.topSaleAndFutureProducts,
                ),
              ),
              DrawerTiles(
                title: 'Orders',
                onTap: () => Get.toNamed(
                  AppLinks.orderHistory,
                ),
              ),
              DrawerTiles(
                title: 'Notifications',
                onTap: () => Get.toNamed(AppLinks.notifications),
              ),
            ],
          ),
          Column(
            children: [
              DrawerTiles(
                title: 'Profile',
                onTap: () => Get.toNamed(AppLinks.profile),
              ),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return DrawerTiles(
                    title: 'Logout',
                    onTap: () => controller.logout(),
                  );
                },
              ),
            ],
          ),
        ],
        child: Scaffold(
          appBar: CustomAppBar(
            haveNotification: widget.haveNotificationIcon,
            onLogoTap: () => _controller.toggle(),
          ),
          body: widget.child,
        ),
      ),
    );
  }
}

class DrawerTiles extends StatelessWidget {
  const DrawerTiles({
    Key? key,
    this.title,
    this.onTap,
  }) : super(key: key);
  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        title: MyText(
          text: '$title',
          size: 17,
          weight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
