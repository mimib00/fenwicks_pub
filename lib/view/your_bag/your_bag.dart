import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/custom_app_bar.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/order_billing_info.dart';
import 'package:fenwicks_pub/view/widget/total_price_and_order_now.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class YourBag extends StatelessWidget {
  YourBag({
    Key? key,
    this.price,
  }) : super(key: key);
  double? price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrderAppBar(
        title: 'Your Bag',
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: 3,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return BagTiles(
                drinkName: 'Drink Name',
                haveDiscount: true,
                newPrice: 198,
                oldPrice: 350,
              );
            },
          ),
          OrderBillingInfo(
            totalCost: 1200,
            deliveryCost: 0.00,
            saved: 165,
          ),
        ],
      ),
      bottomNavigationBar: TotalPriceAndOrderNow(),
    );
  }
}

// ignore: must_be_immutable
class BagTiles extends StatelessWidget {
  BagTiles({
    Key? key,
    this.drinkName,
    this.oldPrice,
    this.newPrice,
    this.haveDiscount = false,
  }) : super(key: key);
  String? drinkName;
  int? oldPrice, newPrice;
  bool? haveDiscount;

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
                      text: '$drinkName',
                      size: 12,
                      weight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                    Row(
                      children: [
                        MyText(
                          paddingRight: 15,
                          text: '\$$newPrice',
                          size: 11,
                          weight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                        haveDiscount == true
                            ? MyText(
                                text: '\$$oldPrice',
                                size: 9,
                                weight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                                color: kSecondaryColor,
                                fontFamily: 'Poppins',
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
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
                    Image.asset(
                      kRemoveIcon,
                      height: 3,
                    ),
                    MyText(
                      text: '2',
                      size: 14,
                      weight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                    Image.asset(
                      kAddIcon,
                      height: 10,
                    ),
                  ],
                ),
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
