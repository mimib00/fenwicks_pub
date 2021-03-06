import 'package:fenwicks_pub/controller/shop_controller.dart';
import 'package:fenwicks_pub/model/order.dart';
import 'package:fenwicks_pub/model/product.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_text.dart';

// ignore: must_be_immutable
class BearGlassWidget extends StatelessWidget {
  final Product? product;
  final bool isGridView;
  const BearGlassWidget({
    Key? key,
    this.product,
    this.isGridView = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetails(product: product)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: isGridView == true ? Get.height : 142,
            width: isGridView == true ? Get.width : 131,
            margin: EdgeInsets.symmetric(
              horizontal: isGridView == true ? 0 : 7,
            ),
            padding: const EdgeInsets.only(
              bottom: 15,
              right: 10,
              left: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kSecondaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyText(
                  text: product!.name,
                  size: isGridView == true ? 17 : 14,
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  paddingBottom: isGridView == true ? 18 : 12,
                  weight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: isGridView == true ? 32 : 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: 1.0,
                            color: kPrimaryColor,
                          ),
                        ),
                        child: Center(
                          child: MyText(
                            text: '\$${product!.price}',
                            maxLines: 1,
                            overFlow: TextOverflow.ellipsis,
                            size: isGridView == true ? 17 : 14,
                            fontFamily: 'Poppins',
                            weight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GetBuilder<ShopController>(
                      builder: (controller) {
                        List<Order> cart = controller.cart;
                        bool inCart = cart.where((element) => product!.id == element.product.id).toList().isNotEmpty;
                        return GestureDetector(
                          onTap: () {
                            if (inCart) {
                              controller.removeFromCart(product!);
                            } else {
                              controller.addToCart(product!);
                            }
                          },
                          child: Container(
                            height: isGridView == true ? 32 : 25,
                            width: isGridView == true ? 38 : 29,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: inCart ? Colors.green : kPrimaryColor,
                            ),
                            child: Center(
                              child: Image.asset(
                                kShoppingCart,
                                height: isGridView == true ? 14 : 11.09,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: isGridView == true ? -75 : -58,
            left: 0,
            right: 0,
            child: Image.asset(
              kBearGlass,
              height: isGridView == true ? 169 : 132,
            ),
          ),
        ],
      ),
    );
  }
}
