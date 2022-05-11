import 'package:fenwicks_pub/controller/events_controller/events_details_view_controller.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/my_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class EventsDetailView extends StatelessWidget {
  const EventsDetailView({
    Key? key,
    this.eventName,
  }) : super(key: key);
  final String? eventName;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventsDetailsViewController>(
      init: EventsDetailsViewController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.32,
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: controller.pageController,
                            onPageChanged: controller.currentIndex,
                            itemCount: controller.getEventsImages.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Image.asset(
                                controller.getEventsImages[index],
                                height: Get.height,
                                alignment: Alignment.topCenter,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          Positioned(
                            bottom: 40,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: controller.pageController,
                                // PageController
                                count: controller.getEventsImages.length,
                                effect: const WormEffect(
                                  dotHeight: 12,
                                  dotWidth: 12,
                                  dotColor: kGreyColor,
                                  activeDotColor: kSecondaryColor,
                                ),
                                // your preferred effect
                                onDotClicked: controller.currentIndex,
                              ),
                            ),
                          ),
                          backButton(),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: Get.height * 0.668,
                    width: Get.width,
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        topLeft: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Image.asset(
                            kBottomSheetHandle,
                            height: 7,
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            children: [
                              MyText(
                                paddingBottom: 10,
                                text: 'Event Name',
                                size: 25,
                                weight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                              MyText(
                                text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum',
                                size: 14,
                                weight: FontWeight.w400,
                                color: kWhiteColor.withOpacity(0.65),
                                fontFamily: 'Poppins',
                                height: 1.7,
                                paddingBottom: 30,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 135,
                                      decoration: ContainerDecorations.detailEventsCardDec,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MyText(
                                            text: 'Happening On',
                                            size: 11,
                                            weight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                          ),
                                          Wrap(
                                            spacing: 2,
                                            crossAxisAlignment: WrapCrossAlignment.end,
                                            children: [
                                              MyText(
                                                text: '21',
                                                size: 38,
                                                weight: FontWeight.w700,
                                                fontFamily: 'Poppins',
                                              ),
                                              MyText(
                                                paddingBottom: 10,
                                                text: 'St',
                                                size: 13,
                                                weight: FontWeight.w200,
                                                fontFamily: 'Poppins',
                                              ),
                                            ],
                                          ),
                                          MyText(
                                            text: 'May, 2022',
                                            size: 13,
                                            weight: FontWeight.w300,
                                            fontFamily: 'Poppins',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 135,
                                      decoration: ContainerDecorations.detailEventsCardDec,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MyText(
                                            text: 'Attendance Rewards',
                                            size: 11,
                                            maxLines: 1,
                                            overFlow: TextOverflow.ellipsis,
                                            weight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                          ),
                                          MyText(
                                            text: '15',
                                            size: 38,
                                            weight: FontWeight.w700,
                                            fontFamily: 'Poppins',
                                          ),
                                          MyText(
                                            text: 'Points',
                                            size: 13,
                                            weight: FontWeight.w300,
                                            fontFamily: 'Poppins',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              MyText(
                                text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum',
                                size: 14,
                                weight: FontWeight.w400,
                                color: kWhiteColor.withOpacity(0.65),
                                fontFamily: 'Poppins',
                                height: 1.7,
                                paddingTop: 20,
                              ),
                              MyText(
                                paddingTop: 20,
                                text: 'Interested People',
                                size: 25,
                                weight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Stack(
                                children: List.generate(
                                  5,
                                  (index) {
                                    var interestedPeoples = controller.interestedPeoples[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: index == 0
                                            ? 150
                                            : index == 1
                                                ? 115
                                                : index == 2
                                                    ? 75
                                                    : index == 3
                                                        ? 40
                                                        : index == 4
                                                            ? 0
                                                            : 0,
                                      ),
                                      child: Image.asset(
                                        interestedPeoples,
                                        height: 59,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              CustomButton(
                                onPressed: () {},
                                text: 'Mark Yourself As Going',
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              socialMediaIcons(),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget socialMediaIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          kFbIcon,
          height: 30.68,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Image.asset(
            kInstaIcon,
            height: 30.68,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Image.asset(
            kTwitterIcon,
            height: 30.68,
          ),
        ),
        Image.asset(
          kWhatsappIcon,
          height: 30.68,
        ),
      ],
    );
  }
}
