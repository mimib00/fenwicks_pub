import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/app_styling.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/my_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  final TabController controller;
  const Login({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: AppStyling.loginSignUpBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
            paddingTop: Get.height * 0.14,
            text: 'Welcome To Fenwick’s',
            size: 26,
            weight: FontWeight.w700,
          ),
          MyText(
            paddingTop: 15,
            paddingBottom: Get.height * 0.045,
            text: 'Sign In To You Account Now!',
            size: 16,
            fontFamily: 'Open Sans',
            weight: FontWeight.w300,
          ),
          MyTextField(
            hintText: 'Email Address',
            paddingBottom: 30.0,
          ),
          MyTextField(
            hintText: 'Password',
            obSecure: true,
            paddingBottom: 35.0,
          ),
          MyButton(
            onTap: () => Get.offAllNamed(AppLinks.events),
            text: 'sign in',
          ),
          MyText(
            onTap: () {},
            paddingTop: 20,
            paddingBottom: 25,
            align: TextAlign.right,
            text: 'Forgot Password?',
            size: 16,
            color: kSecondaryColor,
            fontFamily: 'Open Sans',
          ),
          Image.asset(kOr),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: GestureDetector(
              onTap: () => controller.animateTo(1),
              child: Wrap(
                runSpacing: 10.0,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  MyText(
                    text: 'Don\'t have an account ',
                    weight: FontWeight.w300,
                    size: 18,
                  ),
                  MyText(
                    text: 'SIGNUP   ',
                    weight: FontWeight.w300,
                    size: 18,
                  ),
                  Image.asset(
                    kArrowForwardLight,
                    height: 9.77,
                  ),
                ],
              ),
            ),
          ),
          MyText(
            onTap: () {},
            align: TextAlign.center,
            text: 'Continue As A Guest',
            size: 16,
            color: kSecondaryColor,
            weight: FontWeight.w700,
            decoration: TextDecoration.underline,
          ),
        ],
      ),
    );
  }
}
