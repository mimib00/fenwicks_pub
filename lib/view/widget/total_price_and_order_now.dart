import 'package:fenwicks_pub/controller/shop_controller.dart';
import 'package:fenwicks_pub/model/product.dart';
import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/address/address.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_text.dart';

// ignore: must_be_immutable
class TotalPriceAndOrderNow extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onOrderTap;
  final Product? product;
  const TotalPriceAndOrderNow({
    Key? key,
    this.product,
    this.buttonText = 'Order Now',
    this.onOrderTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 3,
      color: kSecondaryColor,
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: 'Total Price',
                      size: 11,
                      fontFamily: 'Poppins',
                      color: kPrimaryColor,
                      paddingBottom: 2,
                    ),
                    Row(
                      children: [
                        MyText(
                          paddingTop: 1,
                          paddingRight: 2,
                          text: '\$',
                          size: 12,
                          fontFamily: 'Poppins',
                          color: kPrimaryColor,
                        ),
                        GetBuilder<ShopController>(
                          builder: (controller) {
                            return MyText(
                              text: controller.getCartTotal().toString(),
                              size: 23,
                              weight: FontWeight.w700,
                              fontFamily: 'Poppins',
                              color: kPrimaryColor,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              product != null
                  ? SizedBox(
                      width: 128.97,
                      child: MaterialButton(
                        onPressed: FirebaseAuth.instance.currentUser == null
                            ? () => Get.toNamed(AppLinks.auth)
                            : product!.qty > 0
                                ? () => Get.to(() => Address())
                                : () {},
                        height: 45.51,
                        elevation: 10,
                        color: product!.qty > 0 ? kPrimaryColor : kRedColor,
                        splashColor: kWhiteColor.withOpacity(0.1),
                        highlightColor: kWhiteColor.withOpacity(0.1),
                        shape: const StadiumBorder(),
                        child: MyText(
                          text: product!.qty > 0 ? buttonText : "Out Of Stock",
                          size: 13,
                          weight: FontWeight.w500,
                          color: kWhiteColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 128.97,
                      child: MaterialButton(
                        onPressed: FirebaseAuth.instance.currentUser == null
                            ? () => Get.toNamed(AppLinks.auth)
                            : onOrderTap ?? () => Get.to(() => Address()),
                        height: 45.51,
                        elevation: 10,
                        color: kPrimaryColor,
                        splashColor: kWhiteColor.withOpacity(0.1),
                        highlightColor: kWhiteColor.withOpacity(0.1),
                        shape: const StadiumBorder(),
                        child: MyText(
                          text: buttonText,
                          size: 13,
                          weight: FontWeight.w500,
                          color: kWhiteColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
