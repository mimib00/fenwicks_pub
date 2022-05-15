import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/controller/event_controller.dart';
import 'package:fenwicks_pub/model/event.dart';
import 'package:fenwicks_pub/model/users.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/my_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class EventsDetailView extends StatefulWidget {
  final Event? event;
  const EventsDetailView({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  State<EventsDetailView> createState() => _EventsDetailViewState();
}

class _EventsDetailViewState extends State<EventsDetailView> {
  var pageController = PageController();

  RxInt currentIndex = 0.obs;

  final List<String> eventsImages = [
    'assets/images/dummy_detail.png',
    'assets/images/dummy_detail.png',
    'assets/images/dummy_detail.png',
  ];

  List<String> get getEventsImages => eventsImages;

  bool going = false;

  Future<Users> getUserInfo(DocumentReference<Map<String, dynamic>> user) async {
    Map<String, dynamic> data = {};
    String id = "";
    try {
      final temp = await user.get();
      data = temp.data()!;
      id = temp.id;
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }

    return Users.fromJson(data, uid: id);
  }

  List<Users> user = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final users = widget.event!.going;
    final len = users.length > 5 ? 5 : users.length;
    for (var i = 0; i < len; i++) {
      final data = await getUserInfo(users[i]);
      setState(() {
        user.add(data);
      });
    }
    isGoing();
  }

  void isGoing() {
    final AuthController auth = Get.find();
    final current = auth.user.value!;
    if (user.isEmpty) return;
    var me = user.where((element) => current.id == element.id).toList();
    setState(() {
      going = me.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        controller: pageController,
                        onPageChanged: currentIndex,
                        itemCount: getEventsImages.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Image.asset(
                            getEventsImages[index],
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
                            controller: pageController,
                            // PageController
                            count: getEventsImages.length,
                            effect: const WormEffect(
                              dotHeight: 12,
                              dotWidth: 12,
                              dotColor: kGreyColor,
                              activeDotColor: kSecondaryColor,
                            ),
                            // your preferred effect
                            onDotClicked: currentIndex,
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
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        children: [
                          MyText(
                            paddingBottom: 10,
                            text: widget.event!.name,
                            size: 25,
                            weight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                          MyText(
                            text: widget.event!.description,
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
                                      MyText(
                                        text: DateFormat.d().format(widget.event!.date.toDate()),
                                        size: 38,
                                        weight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                      ),
                                      MyText(
                                        text: DateFormat.yMMM().format(widget.event!.date.toDate()),
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
                                        text: widget.event!.points,
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
                              user.length,
                              (index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: index == 4
                                        ? 150
                                        : index == 3
                                            ? 115
                                            : index == 2
                                                ? 75
                                                : index == 4
                                                    ? 40
                                                    : index == 0
                                                        ? 0
                                                        : 0,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: user[index].photo,
                                    errorWidget: (_, url, error) {
                                      return const CircleAvatar(
                                        child: Icon(
                                          Icons.person_rounded,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        backgroundColor: Colors.white,
                                        radius: 25,
                                      );
                                    },
                                    height: 59,
                                  ),
                                  // child: Image.asset(
                                  //   interestedPeoples,
                                  //   height: 59,
                                  // ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomButton(
                            onPressed: () async {
                              final EventController controller = Get.find<EventController>();
                              final AuthController auth = Get.find();
                              final current = auth.user.value!;
                              if (!going) {
                                if (await controller.markAsGoing(widget.event!)) {
                                  setState(() {
                                    going = true;
                                    user.add(current);
                                  });
                                }
                              } else {
                                if (await controller.markAsNotGoing(widget.event!)) {
                                  setState(() {
                                    going = false;
                                    user.removeWhere((element) => element.id == current.id);
                                  });
                                }
                              }
                            },
                            text: going ? "Mark Yourself As Not Going" : 'Mark Yourself As Going',
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
