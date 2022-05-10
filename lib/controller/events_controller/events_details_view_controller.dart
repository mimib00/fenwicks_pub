import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EventsDetailsViewController extends GetxController {
  var pageController = PageController();
  RxInt currentIndex = 0.obs;
  final List<String> eventsImages = [
    'assets/images/dummy_detail.png',
    'assets/images/dummy_detail.png',
    'assets/images/dummy_detail.png',
  ];

  List<String> get getEventsImages => eventsImages;

  final List<String> interestedPeoples = [
    'assets/images/d6.png',
    'assets/images/d4.png',
    'assets/images/d3.png',
    'assets/images/d2.png',
    'assets/images/d1.png',
  ];
}
