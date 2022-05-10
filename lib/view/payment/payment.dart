import 'package:fenwicks_pub/controller/payment_controller/payment_controller.dart';
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
    return GetBuilder<PaymentController>(
      init: PaymentController(),
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
                text:
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod ',
                size: 15,
                weight: FontWeight.w400,
                color: kWhiteColor.withOpacity(0.65),
                fontFamily: 'Poppins',
                paddingBottom: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: 'Payment Method',
                    size: 18,
                    weight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                  Image.asset(
                    kEditIcon,
                    height: 11.93,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => controller.selectedMethod(
                  controller.isDebitCard,
                  0,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  height: 234.51,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 10),
                        color: kBlackColor.withOpacity(0.24),
                        blurRadius: 25,
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/card_bg.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: 'Bank Name',
                            fontFamily: 'Poppins',
                            size: 18,
                            weight: FontWeight.w700,
                          ),
                          Image.asset(
                            'assets/images/visa.png',
                            height: 18.2,
                          ),
                        ],
                      ),
                      MyText(
                        text: '●●●●    ●●●●    ●●●●    4567',
                        size: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              MyText(
                                text: 'CARDHOLDER NAME',
                                size: 7,
                                weight: FontWeight.w700,
                              ),
                              MyText(
                                paddingTop: 15,
                                text: 'John Doe',
                                size: 18,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              MyText(
                                text: 'EXPIRE DATE',
                                size: 7,
                                weight: FontWeight.w700,
                              ),
                              MyText(
                                paddingTop: 15,
                                text: '05 / 2021',
                                size: 18,
                              ),
                            ],
                          ),
                          Container(),
                        ],
                      ),
                    ],
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
                  onTap: () => controller.selectedMethod(
                    controller.isCash,
                    1,
                  ),
                  title: MyText(
                    text: 'Cash on delivery',
                    size: 18,
                    weight: FontWeight.w700,
                    fontFamily: 'Poppins',
                  ),
                  trailing: Radio(
                    toggleable: true,
                    value: controller.isCash!,
                    groupValue: controller.currentMethod,
                    activeColor: kSecondaryColor,
                    onChanged: (value) => controller.selectedMethod(
                      controller.isCash,
                      1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              OrderBillingInfo(
                totalCost: 1200,
                deliveryCost: 0.00,
                saved: 165,
              ),
            ],
          ),
          bottomNavigationBar: TotalPriceAndOrderNow(
            buttonText: 'DONE',
            onOrderTap: () => Get.toNamed(AppLinks.purchaseSuccessful),
          ),
        );
      },
    );
  }
}
