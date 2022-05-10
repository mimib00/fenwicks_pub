import 'package:flutter/cupertino.dart';

class AllEventsCardModel {
  String? icon, title;
  double? iconSize;
  VoidCallback? onTap;

  AllEventsCardModel({
    this.icon,
    this.title,
    this.iconSize,
    this.onTap,
  });
}

class RecentEventsWidgetModel {
  RecentEventsWidgetModel({
    Key? key,
    this.eventName,
    this.image,
    this.date,
    this.score,
    this.location,
  });

  String? eventName, image, date, score, location;
}
