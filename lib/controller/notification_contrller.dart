import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final CollectionReference<Map<String, dynamic>> _ref =
      FirebaseFirestore.instance.collection("orders");

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<Map<String, dynamic>> getOrder(String id) async {
    DocumentSnapshot<Map<String, dynamic>>? doc;
    try {
      doc = await _ref.doc(id).get();
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    return {"data": doc!.data()!, "id": doc.id};
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(
      CupertinoAlertDialog(
        title: Text(title ?? ""),
        content: Text(body ?? ""),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {},
          )
        ],
      ),
    );
  }

  @override
  void onInit() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    //
    const initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final initializationSettings = InitializationSettings(
      android: initialzationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    //
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    //
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;

      if (notification != null && android != null && apple != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: kPrimaryColor,
              icon: "@mipmap/ic_launcher",
            ),
            iOS: const IOSNotificationDetails(),
          ),
        );
      }
    });

    //
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;
      if (notification != null && android != null && apple != null) {
        Get.showSnackbar(
          GetSnackBar(
            title: notification.title,
            message: notification.body,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });

    //
    super.onInit();
  }
}
