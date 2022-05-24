import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:flutter/material.dart';

import 'my_text.dart';

// ignore: must_be_immutable
class OrderBillingInfo extends StatelessWidget {
  OrderBillingInfo({
    Key? key,
    this.totalCost,
  }) : super(key: key);

  double? totalCost;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kBlackColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyText(
            text: 'Order Info',
            size: 16,
            weight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: 'Total Cost',
                size: 12,
                fontFamily: 'Poppins',
              ),
              MyText(
                text: '\$$totalCost',
                size: 12,
                weight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     MyText(
          //       text: 'Delivery Cost',
          //       size: 12,
          //       fontFamily: 'Poppins',
          //     ),
          //     MyText(
          //       text: '\$$deliveryCost',
          //       size: 12,
          //       weight: FontWeight.w700,
          //       fontFamily: 'Poppins',
          //     ),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     MyText(
          //       text: 'Saved',
          //       size: 12,
          //       fontFamily: 'Poppins',
          //     ),
          //     MyText(
          //       text: '\$$saved',
          //       size: 12,
          //       weight: FontWeight.w700,
          //       fontFamily: 'Poppins',
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
