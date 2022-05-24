import 'package:fenwicks_pub/controller/payment_controller/payment_controller.dart';
import 'package:fenwicks_pub/controller/shop_controller.dart';
import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/custom_app_bar.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/order_billing_info.dart';
import 'package:fenwicks_pub/view/widget/total_price_and_order_now.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
      init: ShopController(),
      builder: (controller) {
        return Scaffold(
          appBar: OrderAppBar(
            title: 'Payment',
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              MyText(
                text: 'Select a payment method to pay for the expances of the drinks',
                size: 15,
                weight: FontWeight.w400,
                color: kWhiteColor.withOpacity(0.65),
                fontFamily: 'Poppins',
                paddingBottom: 30,
              ),
              MyText(
                text: 'Payment Method',
                size: 18,
                weight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
              const SizedBox(
                height: 30,
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  unselectedWidgetColor: kWhiteColor,
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () => controller.selectPayment(false),
                  title: MyText(
                    text: 'Debit Card',
                    size: 18,
                    weight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                  trailing: Radio<bool>(
                    toggleable: true,
                    value: false,
                    groupValue: controller.isCash.value,
                    activeColor: kSecondaryColor,
                    onChanged: (value) => controller.selectPayment(false),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Image.asset(kOr),
              const SizedBox(
                height: 15,
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  unselectedWidgetColor: kWhiteColor,
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () => controller.selectPayment(true),
                  title: MyText(
                    text: 'Cash on delivery',
                    size: 18,
                    weight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                  trailing: Radio<bool>(
                    toggleable: true,
                    value: true,
                    groupValue: controller.isCash.value,
                    activeColor: kSecondaryColor,
                    onChanged: (value) => controller.selectPayment(true),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              OrderBillingInfo(
                totalCost: controller.getCartTotal(),
              ),
            ],
          ),
          bottomNavigationBar: TotalPriceAndOrderNow(
            buttonText: 'DONE',
            onOrderTap: () {
              controller.order();
              // Get.toNamed(AppLinks.purchaseSuccessful);
            },
          ),
        );
      },
    );
  }
}
