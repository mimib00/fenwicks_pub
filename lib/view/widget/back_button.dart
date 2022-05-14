import 'package:fenwicks_pub/view/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

IconButton backButton() {
  return IconButton(
    onPressed: () => Get.back(),
    icon: Image.asset(
      kArrowBack,
      height: 14.25,
    ),
  );
}
