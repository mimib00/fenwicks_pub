import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:get/get.dart';

class Bind extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
