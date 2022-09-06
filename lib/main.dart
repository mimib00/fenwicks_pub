import 'package:fenwicks_pub/controller/binding.dart';
import 'package:fenwicks_pub/firebase_options.dart';
import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/app_styling.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.subscribeToTopic('all');

  Stripe.publishableKey =
      "pk_live_51L249gJgDkfkJxuEhiMg6uPBuu12PMt9iqRVyVNqHhvfYqbWkDmKN6mKHvtGOOddsqVwHCeWe7d5AcV5Qp64TPvo00ERH39no8";
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      initialBinding: Bind(),
      title: 'Fenwick\'s Pub',
      theme: AppStyling.styling,
      themeMode: ThemeMode.light,
      initialRoute: AppLinks.getStarted,
      getPages: AppRoutes.pages,
    );
  }
}
