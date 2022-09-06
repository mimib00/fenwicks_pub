import 'package:fenwicks_pub/controller/shop_controller.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/drawer/my_drawer.dart';
import 'package:fenwicks_pub/view/widget/bear_glass_widget.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopSaleAndFutureProducts extends StatelessWidget {
  const TopSaleAndFutureProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          MyText(
            paddingRight: 15,
            paddingLeft: 15,
            paddingBottom: 30.0,
            text: 'Buy drinks from the most fun pub in TOWN!',
            size: 19,
            weight: FontWeight.w900,
            fontFamily: 'Poppins',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
                child: MyText(
                  text: 'Future Products',
                  size: 21,
                  weight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ),
              GetBuilder<ShopController>(
                init: ShopController(),
                builder: (controller) {
                  if (controller.products.isEmpty) {
                    controller.getProducts();
                  }
                  final products = controller.products;

                  if (products.isEmpty) return Container();
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 40,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Align(
                        child: BearGlassWidget(product: product),
                      );
                    },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisExtent: 181,
                      mainAxisSpacing: 55.0,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return TextFormField(
      cursorColor: kSecondaryColor,
      style: const TextStyle(
        fontSize: 16,
        color: kSecondaryColor,
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        hintText: 'Search here...',
        hintStyle: const TextStyle(
          fontSize: 16,
          color: kSecondaryColor,
          fontFamily: 'Poppins',
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: kWhiteColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: kWhiteColor,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
