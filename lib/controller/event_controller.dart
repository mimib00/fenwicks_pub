import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/model/event.dart';
import 'package:fenwicks_pub/view/widget/event_card.dart';
import 'package:get/get.dart';

import '../view/constant/images.dart';
import '../view/widget/error_card.dart';

class EventController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("events");

  RxList<Event> events = <Event>[].obs;

  final List<EventCard> eventCards = [
    const EventCard(
      icon: kConcertIcon,
      title: 'Concert',
      iconSize: 23.75,
      type: EventTypes.concert,
    ),
    const EventCard(
      icon: kDrinkingIcon,
      title: 'Drinking',
      iconSize: 26.31,
      type: EventTypes.drinking,
    ),
    const EventCard(
      icon: kMusicIcon,
      title: 'Dancing',
      iconSize: 23.48,
      type: EventTypes.dancing,
    ),
  ];

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

  /// Mark user as going to that event.
  Future<bool> markAsGoing(Event event) async {
    final AuthController auth = Get.find<AuthController>();
    try {
      _ref.doc(event.id).set(
        {
          "going": FieldValue.arrayUnion(
            [
              FirebaseFirestore.instance.collection("users").doc(auth.user.value!.id)
            ],
          )
        },
        SetOptions(
          merge: true,
        ),
      );
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    events.clear();
    super.dispose();
  }
}
