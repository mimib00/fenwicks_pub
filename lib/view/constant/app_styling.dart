import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:flutter/material.dart';

import 'images.dart';

class AppStyling {
  static final styling = ThemeData(
    scaffoldBackgroundColor: kPrimaryColor,
    fontFamily: 'Muli',
    appBarTheme: const AppBarTheme(
      elevation: 0,
      toolbarHeight: 65,
      backgroundColor: kPrimaryColor,
    ),
    splashColor: kWhiteColor.withOpacity(0.1),
    highlightColor: kWhiteColor.withOpacity(0.1),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: kWhiteColor.withOpacity(0.1),
    ),
  );
  static var loginSignUpBg = const BoxDecoration(
    image: DecorationImage(
      image: AssetImage(kLsBg),
      fit: BoxFit.cover,
    ),
  );
}
