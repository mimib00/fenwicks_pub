import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final AuthController authController = Get.put(AuthController());

  @override
  void onInit() async {
    // messaging.onTokenRefresh.listen((token) async {
    //   await authController.updateUserData({
    //     "token": token
    //   });
    // });
    // final token = await messaging.getToken();

    // await authController.updateUserData({
    //   "token": token
    // });
    super.onInit();
  }
}
