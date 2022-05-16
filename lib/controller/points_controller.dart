import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/model/event.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/loading.dart';
import 'package:get/get.dart';

class PointController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("events");

  Future<bool> validateQRCode(String code) async {
    Get.dialog(const LoadingCard(), barrierDismissible: false);
    try {
      final res = await _ref.where("secret", isEqualTo: code).get();

      Event event = Event.fromJson(res.docs.first.data(), uid: res.docs.first.id);

      if (event.date.toDate().millisecondsSinceEpoch < DateTime.now().millisecondsSinceEpoch) {
        throw "QR Code expiered!";
      }
      _addPoints(event);
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
      return false;
    }
    Get.back();
    return true;
  }

  void _addPoints(Event event) async {
    final AuthController auth = Get.find();
    final CollectionReference<Map<String, dynamic>> ref = FirebaseFirestore.instance.collection("users");
    final current = auth.user.value!;
    try {
      await ref.doc(current.id).set({
        "points": current.points + event.points
      }, SetOptions(merge: true));
      _addToHistory(event);
      await auth.getUserData(current.id!);
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }
  }

  Future<void> _addToHistory(Event event) async {
    final AuthController auth = Get.find();
    final CollectionReference<Map<String, dynamic>> ref = FirebaseFirestore.instance.collection("users");
    final current = auth.user.value!;
    try {
      ref.doc(current.id).set({
        "history": FieldValue.arrayUnion([
          _ref.doc(event.id)
        ])
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }
  }
}
