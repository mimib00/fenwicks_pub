import 'package:fenwicks_pub/model/event.dart';
import 'package:fenwicks_pub/view/events/filtered_event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
import 'my_text.dart';

class EventCard extends StatelessWidget {
  final String icon;
  final String title;
  final double iconSize;

  final EventTypes type;
  const EventCard({
    Key? key,
    required this.icon,
    required this.iconSize,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kSecondaryColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => Get.to(() => FilteredEvents(type: type, title: title)),
            splashColor: kWhiteColor.withOpacity(0.05),
            highlightColor: kWhiteColor.withOpacity(0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  icon,
                  height: iconSize,
                ),
                MyText(
                  paddingTop: 13,
                  text: title,
                  size: 14,
                  align: TextAlign.center,
                  weight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
