import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/qr_scaner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'back_button.dart';
import 'my_text.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.onLogoTap,
    this.haveNotification = false,
  }) : super(key: key);

  VoidCallback? onLogoTap;
  bool? haveNotification;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onLogoTap,
            child: Image.asset(
              kLogo,
              height: 25,
            ),
          ),
        ],
      ),
      actions: [
        haveNotification == true
            ? IconButton(
                onPressed: () {},
                icon: Image.asset(
                  kNotificationIcon,
                  height: 20,
                ),
              )
            : IconButton(
                onPressed: () => Get.to(() => const QRScan()),
                icon: Image.asset(
                  kQrIcon,
                  height: 20,
                ),
              ),
        const SizedBox(width: 5),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}

// ignore: must_be_immutable
class OrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  OrderAppBar({
    Key? key,
    this.title,
  }) : super(key: key);
  String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Image.asset(
              kAppBarBgIcon,
              height: 56,
            ),
          ),
        ],
      ),
      leading: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          backButton(),
        ],
      ),
      centerTitle: true,
      title: MyText(
        paddingTop: 20,
        text: '$title',
        size: 25,
        weight: FontWeight.w700,
        fontFamily: 'Poppins',
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
