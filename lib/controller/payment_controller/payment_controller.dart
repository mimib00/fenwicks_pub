import 'package:get/get.dart';

class PaymentController extends GetxController {
  bool? currentMethod;
  bool? isDebitCard = false, isCash = false;

  void selectedMethod(bool? method, int index) {
    currentMethod = method;
    if (currentMethod == isDebitCard) {
      isDebitCard = true;
      isCash = false;
    } else {
      isCash = true;
      isDebitCard = false;
    }
    update();
  }
}
