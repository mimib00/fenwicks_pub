import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/model/event.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:fenwicks_pub/view/widget/total_reward_points.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RewardHistory extends StatelessWidget {
  const RewardHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: backButton(),
        title: MyText(
          text: 'Reward History',
          size: 18,
          weight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          final user = controller.user.value!;

          user.history.sort(
            (a, b) {
              if (a["date"] == null || b["date"] == null) return 0;
              final first = a["date"] as Timestamp;
              final second = b["date"] as Timestamp;

              return first.compareTo(second);
            },
          );

          final history = user.history;

          if (history[0].isNotEmpty) {
            history.insert(0, {});
          }

          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: totalRewardPoints(user.points),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container();
                      }
                      final date = history[index]["date"] as Timestamp;
                      final doc = history[index]["event"] as DocumentReference<Map<String, dynamic>>;
                      return RewardHistoryTiles(date: date.toDate(), doc: doc);
                    },
                    separatorBuilder: (context, index) {
                      final previusDate = index == 0 ? history[index + 1]["date"] as Timestamp : history[index]["date"] as Timestamp;

                      if (index == 0) return DateTile(date: previusDate.toDate());
                      final date = history[index + 1]["date"] as Timestamp;
                      if (date.toDate().month != previusDate.toDate().month) return DateTile(date: date.toDate());
                      return Container();
                    },
                    itemCount: history.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DateTile extends StatelessWidget {
  final DateTime date;
  const DateTile({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final month = DateFormat.MMMM().format(date);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            text: "$month ${date.year}",
            size: 18,
            weight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ],
      ),
    );
  }
}

class RewardHistoryTiles extends StatelessWidget {
  final DateTime date;
  final DocumentReference<Map<String, dynamic>> doc;
  const RewardHistoryTiles({
    Key? key,
    required this.date,
    required this.doc,
  }) : super(key: key);

  Future<EventModel> getEvent() async {
    DocumentSnapshot<Map<String, dynamic>>? snap;
    try {
      snap = await doc.get();
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }

    return EventModel.fromJson(snap!.data()!, uid: snap.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EventModel>(
        future: getEvent(),
        builder: (context, snapshot) {
          if (snapshot.data == null) return Container();

          final event = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 15,
              left: 15,
              right: 15,
            ),
            child: ListTile(
              minLeadingWidth: 25,
              onTap: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              tileColor: kBlackColor,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kCoin3,
                    height: 25.84,
                  ),
                ],
              ),
              title: MyText(
                paddingBottom: 7,
                text: 'Total Reward : ${event.points} Points',
                size: 17,
                weight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
              subtitle: MyText(
                text: '${event.points} points rewarded on going on event\n"${event.name}"',
                size: 11,
                maxLines: 2,
                overFlow: TextOverflow.ellipsis,
                fontFamily: 'Poppins',
              ),
              trailing: MyText(
                height: 1.1,
                text: date.day.toString(),
                size: 37,
                color: kSecondaryColor,
                weight: FontWeight.w900,
                fontFamily: 'Poppins',
              ),
            ),
          );
        });
  }
}

class CalendarPopUp extends StatefulWidget {
  const CalendarPopUp({Key? key}) : super(key: key);

  @override
  _CalendarPopUpState createState() => _CalendarPopUpState();
}

class _CalendarPopUpState extends State<CalendarPopUp> {
  final DateTime _currentDate = DateTime(2019, 2, 3);
  DateTime _currentDate2 = DateTime(2019, 2, 3);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
  DateTime _targetDateTime = DateTime(2019, 2, 3);

  @override
  Widget build(BuildContext context) {
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: kSecondaryColor,
      onDayPressed: (date, events) {
        setState(() => _currentDate2 = date);
        for (var event in events) {
          if (kDebugMode) {
            print(event.title);
          }
        }
      },
      showHeaderButton: false,
      daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: false,
      iconColor: kGreyColor3,
      weekendTextStyle: const TextStyle(
        color: kGreyColor,
        fontFamily: 'Poppins',
        fontSize: 14,
      ),
      weekFormat: false,
      dayPadding: 6,
      weekDayMargin: const EdgeInsets.symmetric(vertical: 10),
      daysTextStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: kBlackColor,
        fontSize: 14,
      ),
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      showHeader: false,
      selectedDayButtonColor: kSecondaryColor,
      pageScrollPhysics: const BouncingScrollPhysics(),
      //Selected Date
      selectedDayTextStyle: const TextStyle(
        color: kWhiteColor,
        fontFamily: 'Poppins',
        fontSize: 14,
      ),
      weekdayTextStyle: const TextStyle(
        color: kBlackColor,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
        fontSize: 14,
      ),
      todayTextStyle: const TextStyle(
        color: kWhiteColor,
        fontFamily: 'Poppins',
        fontSize: 14,
      ),
      childAspectRatio: 0.9,
      minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
      maxSelectedDate: _currentDate.add(const Duration(days: 360)),
      prevDaysTextStyle: const TextStyle(
        color: kBlackColor,
        fontFamily: 'Poppins',
        fontSize: 14,
      ),
      inactiveDaysTextStyle: const TextStyle(
        color: kBlackColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
        fontSize: 14,
      ),
      nextMonthDayBorderColor: Colors.transparent,
      prevMonthDayBorderColor: Colors.transparent,
      thisMonthDayBorderColor: Colors.transparent,
      selectedDayBorderColor: Colors.transparent,
      nextDaysTextStyle: const TextStyle(
        color: kBlackColor,
        fontFamily: 'Poppins',
        fontSize: 14,
      ),
      inactiveWeekendTextStyle: const TextStyle(
        color: kBlackColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
        fontSize: 14,
      ),
      markedDateCustomTextStyle: const TextStyle(
        color: kBlackColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
        fontSize: 14,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
        });
      },
      onDayLongPressed: (DateTime date) {
        if (kDebugMode) {
          print('long pressed date $date');
        }
      },
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              text: 'Calender',
              size: 18,
              weight: FontWeight.w500,
              color: kPrimaryColor,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _targetDateTime = DateTime(
                        _targetDateTime.year,
                        _targetDateTime.month - 1,
                      );
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                  child: Image.asset(
                    'assets/images/arrow_back.png',
                    height: 15,
                  ),
                ),
                MyText(
                  text: _currentMonth,
                  color: kBlackColor,
                  paddingLeft: 10,
                  paddingRight: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month + 1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Image.asset(
                      'assets/images/arrow_back.png',
                      height: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 300,
          child: _calendarCarouselNoHeader,
        ),
      ],
    );
  }
}
