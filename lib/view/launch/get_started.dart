// import 'package:fenwicks_pub/routes/routes.dart';
// import 'package:fenwicks_pub/view/constant/color.dart';
// import 'package:fenwicks_pub/view/constant/images.dart';
// import 'package:fenwicks_pub/view/widget/my_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class GetStarted extends StatelessWidget {
//   const GetStarted({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: Get.width,
//         height: Get.height,
//         padding: const EdgeInsets.symmetric(
//           horizontal: 30,
//         ),
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(kIntroBg),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               kLogo,
//               height: 53.75,
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Wrap(
//               runSpacing: 10.0,
//               children: [
//                 MyText(
//                   text: 'Fenwick’s '.toUpperCase(),
//                   size: 30,
//                   weight: FontWeight.w700,
//                 ),
//                 MyText(
//                   text: 'Pub'.toUpperCase(),
//                   size: 30,
//                   color: kSecondaryColor,
//                   weight: FontWeight.w700,
//                 ),
//               ],
//             ),
//             MyText(
//               paddingTop: 20,
//               paddingBottom: 30,
//               text: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et',
//               size: 16,
//               weight: FontWeight.w600,
//               fontFamily: 'Open Sans',
//               height: 1.6,
//             ),
//             GestureDetector(
//               onTap: () => Get.offAllNamed(AppLinks.login),
//               behavior: HitTestBehavior.opaque,
//               child: Row(
//                 children: [
//                   MyText(
//                     paddingRight: 10,
//                     text: 'Get Started',
//                     size: 16,
//                     weight: FontWeight.w700,
//                   ),
//                   Image.asset(
//                     kArrowForwardBold,
//                     height: 15.77,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
