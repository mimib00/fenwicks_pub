import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/model/order.dart';
import 'package:fenwicks_pub/model/users.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/orders/order_details.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends GetView<AuthController> {
  const NotificationScreen({Key? key}) : super(key: key);
  Stream<DocumentSnapshot<Map<String, dynamic>>> listenToUser(String id) {
    return FirebaseFirestore.instance.collection("users").doc(id).snapshots();
  }

  // Future<Users> getUserData(DocumentSnapshot<Map<String, dynamic>> user) async {
  //   Users? users;
  //   try {
  //     final data = await user.data();
  //   } on FirebaseException catch (e) {
  //     Get.showSnackbar(errorCard(e.message!));
  //   }
  //   return users!;
  // }

  @override
  Widget build(BuildContext context) {
    final user = controller.user.value!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: backButton(),
        title: MyText(
          text: 'Notifications',
          size: 18,
          weight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: listenToUser(user.id!),
          builder: (context, snapshot) {
            if (snapshot.data == null) return Container();
            final users = Users.fromJson(snapshot.data!.data()!, uid: snapshot.data!.id);
            final notifications = users.notifications;
            notifications.sort((a, b) => b.date.compareTo(a.date));
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationTile(notification: notification);
              },
            );
          }),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final Notifications notification;
  const NotificationTile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  Future<Map<String, dynamic>> getOrder(String id) async {
    final CollectionReference<Map<String, dynamic>> ref = FirebaseFirestore.instance.collection("orders");
    Map<String, dynamic> order = {};
    try {
      final doc = await ref.doc(id).get();
      order = doc.data()!;
      order.addAll({"id": id});
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }

    return order;
  }

  @override
  Widget build(BuildContext context) {
    final date = notification.date.toDate();
    return FutureBuilder<Map<String, dynamic>>(
        future: notification.order != null ? getOrder(notification.order!) : null,
        builder: (context, snapshot) {
          if (snapshot.data == null && notification.order != null) return Container();
          print(snapshot.data);
          return ListTile(
            onTap: notification.order == null ? null : () => Get.to(() => OrderDetails(order: snapshot.data!)),
            enableFeedback: notification.order != null,
            title: MyText(
              height: 1.1,
              text: notification.title,
              size: 17,
              weight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
            subtitle: MyText(
              height: 1.1,
              text: notification.msg,
              size: 14,
              weight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MyText(
                  height: 1.1,
                  text: date.day.toString(),
                  size: 37,
                  color: kSecondaryColor,
                  weight: FontWeight.w900,
                  fontFamily: 'Poppins',
                ),
                MyText(
                  text: DateFormat.yMMM().format(date),
                  size: 9,
                  color: kSecondaryColor,
                  weight: FontWeight.w700,
                  fontFamily: 'Poppins',
                ),
              ],
            ),
          );
        });
  }
}
