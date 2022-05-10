import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/constant/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Fenwick\'s Pub',
      theme: AppStyling.styling,
      themeMode: ThemeMode.light,
      initialRoute: AppLinks.splashScreen,
      getPages: AppRoutes.pages,
    );
  }
}
