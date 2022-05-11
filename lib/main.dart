import 'package:fenwicks_pub/controller/binding.dart';
import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/app_styling.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: AppLinks.splashScreen,
      getPages: AppRoutes.pages,
    );
  }
}
