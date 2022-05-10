import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/my_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';

class VerifyPassword extends StatelessWidget {
  const VerifyPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: backButton(),
        title: MyText(
          text: 'Password',
          size: 18,
          weight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Image.asset(kVerifyPassword),
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyText(
                    paddingTop: 40,
                    text: 'Enter your password below to verify\nyour attendance',
                    size: 16,
                    align: TextAlign.center,
                    weight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    paddingBottom: 20,
                  ),
                  TextFormField(
                    cursorColor: kSecondaryColor,
                    style: TextStyle(
                      fontSize: 16,
                      color: kWhiteColor.withOpacity(0.65),
                      fontFamily: 'Poppins',
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 16,
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: kWhiteColor.withOpacity(0.65),
                        fontFamily: 'Poppins',
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: kSecondaryColor,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: kSecondaryColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              onPressed: () {},
              text: 'Verify',
              textSize: 20,
              weight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
