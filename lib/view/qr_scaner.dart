import 'package:fenwicks_pub/controller/points_controller.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan/scan.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  State<QRScan> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  ScanController controller = ScanController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: backButton(),
        title: MyText(
          text: 'Scan QR',
          size: 18,
          weight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
      body: GetBuilder<PointController>(
          init: PointController(),
          builder: (ctrl) {
            return ScanView(
              controller: controller,
              scanAreaScale: .7,
              scanLineColor: Colors.green.shade400,
              onCapture: (data) async {
                if (await ctrl.validateQRCode(data)) Get.back();
              },
            );
          }),
    );
  }
}
