import 'dart:async';
import 'package:fenwicks_pub/view/launch/new_get_started.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  getCurrentUser() {
    Timer(
      const Duration(
        seconds: 3,
      ),
      () => Get.offAll(() => const NewGetStarted()),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<SplashScreenController>();
  }
}
