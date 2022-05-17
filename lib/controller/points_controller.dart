import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/model/event.dart';
import 'package:fenwicks_pub/model/users.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/loading.dart';
import 'package:get/get.dart';

class PointController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("events");
  final AuthController auth = Get.find();
  Users get current => auth.user.value!;

  Future<bool> validateQRCode(String code) async {
    Get.dialog(const LoadingCard(), barrierDismissible: false);
    try {
      final res = await _ref.where("secret", isEqualTo: code).get();

      Event event = Event.fromJson(res.docs.first.data(), uid: res.docs.first.id);

      if (event.date.toDate().millisecondsSinceEpoch < DateTime.now().millisecondsSinceEpoch) {
        Get.back();
        throw "QR Code expiered!";
      }
      if (await _claimCheck(event)) return false;

      _addPoints(event);
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
      return false;
    }
    Get.back();
    return true;
  }

  Future<bool> _claimCheck(Event event) async {
    try {
      if (current.history.isEmpty) return false;

      final item = current.history.where((element) => _ref.doc(event.id) == element["event"]).toList();
      if (item.isNotEmpty) {
        Get.back();
        throw "Reward already claimed";
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.toString()));
      return true;
    }
    return false;
  }

  void _addPoints(Event event) async {
    final CollectionReference<Map<String, dynamic>> ref = FirebaseFirestore.instance.collection("users");

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
    final CollectionReference<Map<String, dynamic>> ref = FirebaseFirestore.instance.collection("users");
    final history = current.history;

    try {
      history.add({
        "date": Timestamp.now(),
        "event": _ref.doc(event.id),
      });
      ref.doc(current.id).update({
        "history": history,
      });
    } on FirebaseException catch (e) {
      Get.back();
      Get.showSnackbar(errorCard(e.message!));
    }
  }
}
