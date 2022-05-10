import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
            ),
            child: Row(
              children: [
                Expanded(
                  child: searchBox(),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  kFilterIcon,
                  height: 49,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: 'Top Sale',
                      size: 21,
                      weight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                    MyText(
                      onTap: () => Get.toNamed(
                        AppLinks.topSaleAndFutureProducts,
                      ),
                      text: 'View All',
                      size: 18,
                      color: kWhiteColor.withOpacity(0.5),
                      weight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Align(
                      child: BearGlassWidget(
                        drinkName: 'Drink Name',
                        price: 88,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: 'Future Products',
                      size: 21,
                      weight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                    MyText(
                      onTap: () => Get.toNamed(
                        AppLinks.topSaleAndFutureProducts,
                      ),
                      text: 'View All',
                      size: 18,
                      color: kWhiteColor.withOpacity(0.5),
                      weight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                  ],
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 40,
                ),
                itemBuilder: (context, index) {
                  return Align(
                    child: BearGlassWidget(
                      drinkName: 'Drink Name',
                      price: 88,
                      isGridView: true,
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 181,
                  mainAxisSpacing: 55.0,
                ),
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
