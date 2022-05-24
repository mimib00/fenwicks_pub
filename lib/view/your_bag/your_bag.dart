import 'package:fenwicks_pub/controller/shop_controller.dart';
import 'package:fenwicks_pub/model/order.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/custom_app_bar.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/order_billing_info.dart';
import 'package:fenwicks_pub/view/widget/total_price_and_order_now.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class YourBag extends StatelessWidget {
  const YourBag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(builder: (controller) {
      List<Order> cart = controller.cart;
      return Scaffold(
        appBar: OrderAppBar(
          title: 'Your Bag',
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: cart.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final order = cart[index];
                return BagTiles(order: order);
              },
            ),
            OrderBillingInfo(
              totalCost: controller.getCartTotal(),
            ),
          ],
        ),
        bottomNavigationBar: const TotalPriceAndOrderNow(),
      );
    });
  }
}

// ignore: must_be_immutable
class BagTiles extends StatelessWidget {
  final Order order;
  const BagTiles({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 40,
          ),
          height: 94,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kBlackColor,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 110,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MyText(
                      paddingBottom: 10,
                      text: order.product.name,
                      size: 12,
                      weight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                    Row(
                      children: [
                        MyText(
                          paddingRight: 15,
                          text: order.product.price.toString(),
                          size: 11,
                          weight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GetBuilder<ShopController>(
                builder: (controller) {
                  return Container(
                    margin: const EdgeInsets.only(
                      right: 20,
                    ),
                    height: 28.83,
                    width: 73.82,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: kBlackColor.withOpacity(0.10),
                          offset: const Offset(0, 3),
                          blurRadius: 25,
                        ),
                      ],
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.changeQuantity(order, -1);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Expanded(
                            child: Image.asset(
                              kRemoveIcon,
                              height: 3,
                            ),
                          ),
                        ),
                        MyText(
                          text: order.quantity.toString(),
                          size: 14,
                          weight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.changeQuantity(order, 1);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Expanded(
                            child: Image.asset(
                              kAddIcon,
                              height: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: -65,
          left: -33,
          child: Image.asset(
            kBearGlass,
            height: 175,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
