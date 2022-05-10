import 'package:flutter/material.dart';

import 'images.dart';

const kPrimaryColor = Color(0xff1C1D1A);
const kSecondaryColor = Color(0xffC89D66);
const kWhiteColor = Color(0xffFFFFFF);
const kBlackColor = Color(0xff000000);
const kGreyColor = Color(0xffD9CECE);
const kGreyColor2 = Color(0xffE5E5E5);
const kGreyColor3 = Color(0xff989898);
const kGreyColor4 = Color(0xff7A8FA6);
const kRedColor = Color(0xffFF0000);
const kSkyBlueColor = Color(0xff9AD3F4);
const kSkyBlueColor2 = Color(0xff7A8FA6);

class ContainerDecorations {
  static var detailEventsCardDec = BoxDecoration(
    borderRadius: BorderRadius.circular(7),
    image: const DecorationImage(
      image: AssetImage(kDetailEventCardBg),
      fit: BoxFit.cover,
    ),
  );
  static var customDivider = Image.asset('assets/images/Line 3.png');
  static var circle = 'assets/images/circle.png';
}
