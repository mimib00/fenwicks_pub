import 'package:fenwicks_pub/model/product.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/total_price_and_order_now.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../your_bag/your_bag.dart';

// ignore: must_be_immutable
class ProductDetails extends StatelessWidget {
  final Product? product;
  const ProductDetails({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            backButton(),
          ],
        ),
        centerTitle: true,
        title: MyText(
          text: product!.name,
          size: 24,
          weight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 5,
            ),
            child: IconButton(
              onPressed: () => Get.to(
                () => YourBag(
                  price: product!.price,
                ),
              ),
              icon: Image.asset(
                kAddToCart,
                height: 37,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        children: [
          detailAboutDrink(),
          const SizedBox(
            height: 60,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 375,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kSecondaryColor.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: -175,
                left: 50,
                right: 0,
                child: Image.asset(
                  kBearBigGlass,
                  height: 526,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 70,
                child: priceTag(200),
              ),
            ],
          ),
          MyText(
            paddingTop: 30,
            text: 'Product Details',
            size: 25,
            weight: FontWeight.w600,
            fontFamily: 'Poppins',
            paddingBottom: 10,
          ),
          MyText(
            text: product!.description,
            size: 15,
            weight: FontWeight.w400,
            color: kWhiteColor.withOpacity(0.65),
            height: 1.7,
            fontFamily: 'Poppins',
          ),
        ],
      ),
      bottomNavigationBar: TotalPriceAndOrderNow(product: product),
    );
  }

  Widget detailAboutDrink() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyText(
                text: 'Reviews',
                paddingBottom: 7,
                size: 19,
                weight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
              RatingBarIndicator(
                rating: double.parse(product!.rating.toString()),
                unratedColor: kSecondaryColor.withOpacity(0.3),
                itemBuilder: (context, index) => Image.asset(
                  kRatingStar,
                  height: 12.87,
                ),
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                itemSize: 12.87,
                direction: Axis.horizontal,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyText(
                text: 'Level',
                paddingBottom: 7,
                size: 19,
                weight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
              MyText(
                text: 'Strong',
                size: 17,
                color: kSecondaryColor,
                weight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyText(
                text: 'Serving',
                paddingBottom: 7,
                size: 19,
                weight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
              MyText(
                text: 'People : ${product!.servings}',
                size: 17,
                color: kSecondaryColor,
                weight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget priceTag(int price) {
    return Container(
      width: 189,
      height: 65,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withOpacity(0.16),
            offset: const Offset(0, 12),
            blurRadius: 20,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(
            text: 'Price: ',
            size: 22,
            fontFamily: 'Poppins',
          ),
          MyText(
            text: '\$${product!.price}',
            size: 22,
            weight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ],
      ),
    );
  }
}
