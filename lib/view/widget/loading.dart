import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: Get.width * .7,
          height: Get.height * .1,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Loading",
                style: TextStyle(fontFamily: "Muli", fontWeight: FontWeight.w600, fontSize: 20),
              ),
              SizedBox(width: 10),
              CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  final String title;
  const StatusCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: Get.width * .7,
          height: Get.height * .1,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontFamily: "Muli", fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const SizedBox(width: 10),
              const CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
