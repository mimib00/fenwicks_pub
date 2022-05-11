import 'package:fenwicks_pub/controller/events_controller/events_controller.dart';
import 'package:fenwicks_pub/controller/shop_controller.dart';
import 'package:fenwicks_pub/model/events_model/events_model.dart';
import 'package:fenwicks_pub/model/product.dart';
import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/drawer/my_drawer.dart';
import 'package:fenwicks_pub/view/events/events_detail_view.dart';
import 'package:fenwicks_pub/view/widget/bear_glass_widget.dart';
import 'package:fenwicks_pub/view/widget/horizontal_calendar.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/total_reward_points.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

// ignore: must_be_immutable
class Events extends StatelessWidget {
  const Events({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsController>(
      init: EventsController(),
      builder: (controller) {
        return MyDrawer(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            children: [
              const ProfileTile(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: totalRewardPoints(20),
              ),
              MyText(
                paddingTop: 15,
                text: 'Spend your points now!',
                align: TextAlign.center,
                weight: FontWeight.w300,
                fontFamily: 'Poppins',
                paddingBottom: 20,
              ),
              Center(
                child: Container(
                  width: Get.width * 0.8,
                  height: 1,
                  color: kWhiteColor.withOpacity(0.10),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const HorizontalCalendar(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: 'All Events',
                          size: 16,
                          weight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                        MyText(
                          onTap: () {},
                          text: 'View All',
                          size: 11,
                          weight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                      ),
                      itemCount: controller.getAllEventsCardsData.length,
                      itemBuilder: (context, index) {
                        var data = controller.getAllEventsCardsData[index];
                        return allEventsCards(data);
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: 'Recent Events',
                          size: 16,
                          weight: FontWeight.w700,
                        ),
                        MyText(
                          onTap: () {},
                          text: 'View All',
                          size: 11,
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    itemCount: controller.getRecentEvents.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = controller.getRecentEvents[index];
                      return RecentEventsWidget(
                        eventName: data.eventName,
                        date: data.date,
                        score: data.score,
                        location: data.location,
                        image: data.image,
                      );
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: 'Shop',
                          size: 16,
                          weight: FontWeight.w700,
                          fontFamily: 'Poppins',
                        ),
                        MyText(
                          onTap: () => Get.toNamed(
                            AppLinks.topSaleAndFutureProducts,
                          ),
                          text: 'View All',
                          size: 11,
                          weight: FontWeight.w400,
                          fontFamily: 'Poppins',
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<ShopController>(
                    init: ShopController(),
                    builder: (controller) {
                      if (controller.products.isEmpty) {
                        controller.getAllProducts();
                      }
                      final products = controller.products;
                      if (products.isEmpty) return Container();
                      return SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                          ),
                          itemCount: products.length > 5 ? 5 : products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Row(
                              children: [
                                BearGlassWidget(
                                  product: product,
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget allEventsCards(AllEventsCardModel data) {
    return Container(
      height: Get.height,
      margin: const EdgeInsets.symmetric(
        horizontal: 7,
      ),
      width: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kSecondaryColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: data.onTap,
          splashColor: kWhiteColor.withOpacity(0.05),
          highlightColor: kWhiteColor.withOpacity(0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                data.icon!,
                height: data.iconSize,
              ),
              MyText(
                paddingTop: 13,
                text: data.title,
                size: 14,
                align: TextAlign.center,
                weight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class RecentEventsWidget extends StatelessWidget {
  RecentEventsWidget({
    Key? key,
    this.eventName,
    this.image,
    this.date,
    this.score,
    this.location,
  }) : super(key: key);

  String? eventName, image, date, score, location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => EventsDetailView(
          eventName: eventName,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        height: 93,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kBlackColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MyText(
                      text: '$eventName',
                      size: 14,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      weight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Image.asset(
                                kCalendarIcon,
                                height: 8.69,
                              ),
                              Expanded(
                                child: MyText(
                                  paddingLeft: 10,
                                  text: '$date',
                                  size: 9,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  weight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Row(
                            children: [
                              Image.asset(
                                kBadgeIcon,
                                height: 9.07,
                              ),
                              Expanded(
                                child: MyText(
                                  paddingLeft: 10,
                                  text: '$score',
                                  size: 9,
                                  maxLines: 1,
                                  overFlow: TextOverflow.ellipsis,
                                  weight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          kLocationIcon,
                          height: 11.28,
                        ),
                        Expanded(
                          child: MyText(
                            paddingLeft: 10,
                            text: '$location',
                            size: 9,
                            maxLines: 1,
                            overFlow: TextOverflow.ellipsis,
                            weight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Image.asset(
                '$image',
                height: 93,
                width: 103,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        final user = controller.user.value!;
        final name = user.name.split(" ")[0];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          title: MyText(
            text: 'Hello, $name!',
            size: 18,
            weight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
          subtitle: MyText(
            paddingTop: 5,
            text: 'Let\'s explore what’s happening nearby',
            size: 14,
            weight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
          trailing: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: kSecondaryColor,
            ),
            child: Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  kDummyUser,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
