import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/model/event.dart';
import 'package:get/get.dart';

import '../view/widget/error_card.dart';

class EventController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("events");

  RxList<Event> events = <Event>[].obs;

  /// Gets list of the coming events.
  void getComingEvents() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
    try {
      final temp = await _ref.where('date', isGreaterThanOrEqualTo: Timestamp.now()).get();
      docs = temp.docs;
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    for (var doc in docs) {
      events.add(Event.fromJson(doc.data(), uid: doc.id));
    }
    update();
  }

  @override
  void dispose() {
    events.clear();
    super.dispose();
  }
}
