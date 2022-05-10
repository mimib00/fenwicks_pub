import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PostDetailsController extends GetxController {
  var pageController = PageController();


  int currentIndex = 0;
  final List<String> postImages = [
    'assets/images/32.png',
    'assets/images/Group 23.png',
    'assets/images/32.png',
    'assets/images/Group 23.png',
    'assets/images/32.png',
    'assets/images/Group 23.png',
  ];

  List<String> get getPostImage => postImages;

  void currentPage(int index) {
    currentIndex = index;
    update();
  }
}
