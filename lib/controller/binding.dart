import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/controller/location_controller.dart';
import 'package:fenwicks_pub/controller/notification_contrller.dart';
import 'package:get/get.dart';

class Bind extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationController(), permanent: true);
    Get.put(AuthController());
    Get.put(NotificationController());
  }
}
