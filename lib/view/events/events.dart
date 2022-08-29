import 'package:cached_network_image/cached_network_image.dart';
import 'package:fenwicks_pub/controller/shop_controller.dart';
import 'package:fenwicks_pub/model/event.dart';
import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/drawer/my_drawer.dart';
import 'package:fenwicks_pub/view/events/events_detail_view.dart';
import 'package:fenwicks_pub/view/widget/bear_glass_widget.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/total_reward_points.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/auth_controller.dart';
import '../../controller/event_controller.dart';

class Events extends StatelessWidget {
  const Events({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(
      init: EventController(),
      builder: (controller) {
        if (controller.events.isEmpty) {
          controller.getComingEvents();
        }
        final events = controller.events;

        return MyDrawer(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 15),
            children: [
              const ProfileTile(),
              const SizedBox(height: 30),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: totalRewardPoints(controller.user.value?.points ?? 0),
                      ),
                      Visibility(
                        visible: controller.user.value?.points == null ? false : controller.user.value!.points > 0,
                        child: MyText(
                          paddingTop: 15,
                          text: 'Spend your points now!',
                          align: TextAlign.center,
                          weight: FontWeight.w300,
                          fontFamily: 'Poppins',
                          paddingBottom: 20,
                        ),
                      ),
                    ],
                  );
                },
              ),
              Center(
                child: Container(
                  width: Get.width * 0.8,
                  height: 1,
                  color: kWhiteColor.withOpacity(0.10),
                ),
              ),
              const SizedBox(height: 20),
              // const HorizontalCalendar(),
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: Get.width,
                    child: Row(
                      children: controller.eventCards,
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
                  events.isEmpty
                      ? Container()
                      : ListView.builder(
                          itemCount: events.length > 4 ? 4 : events.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = events[index];

                            return RecentEventsWidget(event: data);
                          },
                        )
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
                    builder: (ctrl) {
                      if (ctrl.products.isEmpty) {
                        ctrl.getAllProducts();
                      }
                      final products = ctrl.products;
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
}

class RecentEventsWidget extends StatelessWidget {
  final EventModel event;
  const RecentEventsWidget({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMMd().format(event.date.toDate());
    return GestureDetector(
      onTap: () => Get.to(
        () => EventsDetailView(event: event),
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
                      text: event.name,
                      size: 14,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      weight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              kCalendarIcon,
                              height: 8.69,
                            ),
                            MyText(
                              paddingLeft: 10,
                              text: date,
                              size: 9,
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                              weight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Image.asset(
                              kBadgeIcon,
                              height: 9.07,
                            ),
                            MyText(
                              // paddingLeft: 10,
                              text: "${event.points} Reward points",
                              size: 9,
                              maxLines: 1,
                              overFlow: TextOverflow.ellipsis,
                              weight: FontWeight.w400,
                              fontFamily: 'Poppins',
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          kLocationIcon,
                          height: 11.28,
                        ),
                        MyText(
                          paddingLeft: 10,
                          text: event.address,
                          size: 9,
                          maxLines: 1,
                          overFlow: TextOverflow.ellipsis,
                          weight: FontWeight.w400,
                          fontFamily: 'Poppins',
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
                "assets/images/dummy_1.png",
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
        final user = controller.user.value;
        final name = user?.name.split(" ")[0];
        return ListTile(
          title: MyText(
            text: name == null ? 'Hello, There!' : 'Hello, $name!',
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: CachedNetworkImage(
                imageUrl: user?.photo ?? "",
                fit: BoxFit.cover,
                height: 60,
                width: 50,
                errorWidget: (_, __, ___) => const CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: Icon(
                    Icons.person_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
