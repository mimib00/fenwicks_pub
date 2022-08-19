import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/model/users.dart';
import 'package:fenwicks_pub/view/constant/app_styling.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/my_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  final TabController controller;
  SignUp({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController name = TextEditingController();

  final TextEditingController phone = TextEditingController();

  bool accepted = false;

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
            text: 'Sign Up On Our App Today!',
            size: 16,
            fontFamily: 'Open Sans',
            weight: FontWeight.w300,
          ),
          MyTextField(
            controller: name,
            hintText: 'Full Name',
            paddingBottom: 30.0,
            keyboardType: TextInputType.name,
          ),
          MyTextField(
            controller: email,
            hintText: 'Email Address',
            paddingBottom: 30.0,
            keyboardType: TextInputType.emailAddress,
          ),
          MyTextField(
            controller: phone,
            hintText: 'Phone',
            paddingBottom: 30.0,
            keyboardType: TextInputType.phone,
          ),
          MyTextField(
            controller: password,
            hintText: 'Password',
            obSecure: true,
            paddingBottom: 30.0,
          ),
          MyTextField(
            controller: confirmPassword,
            hintText: 'Confirm Password',
            obSecure: true,
            paddingBottom: 35.0,
          ),
          Row(
            children: [
              Checkbox(
                value: accepted,
                onChanged: (value) {
                  setState(() {
                    accepted = value!;
                  });
                },
                side: const BorderSide(color: Colors.white, width: 1.78),
                fillColor: MaterialStateProperty.all(Colors.white),
                checkColor: Colors.black,
              ),
              const Text(
                'I accept ',
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  final Uri _url = Uri.parse('https://www.apple.com/legal/internet-services/itunes/dev/stdeula/');

                  launchUrl(_url);
                },
                child: const Text(
                  'terms & conditions',
                  style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          MyButton(
            onTap: () {
              if (accepted) {
                final AuthController auth = Get.put(AuthController());
                if (name.text.trim().isNotEmpty &&
                    email.text.trim().isNotEmpty &&
                    phone.text.trim().isNotEmpty &&
                    password.text.trim().isNotEmpty &&
                    confirmPassword.text.trim().isNotEmpty) {
                  if (password.text.trim() == confirmPassword.text.trim()) {
                    Map<String, dynamic> data = {
                      "email": email.text.trim(),
                      "name": name.text.trim(),
                      "phone": phone.text.trim(),
                    };
                    var user = Users.fromJson(data);
                    auth.register(user, password.text.trim());
                  }
                } else {
                  return;
                }
              } else {
                Get.snackbar(
                  "Required",
                  "you need to read and accept terms and conditions",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                );
              }
            },
            text: 'SIGN UP',
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset(kOr),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: GestureDetector(
              onTap: () => widget.controller.animateTo(0),
              child: Wrap(
                runSpacing: 10.0,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  MyText(
                    text: 'Already have an account ',
                    weight: FontWeight.w300,
                    size: 18,
                  ),
                  MyText(
                    text: 'SIGNIN   ',
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
        ],
      ),
    );
  }
}
