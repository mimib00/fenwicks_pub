import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetails({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = order["data"];
    final id = order["id"];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: backButton(),
        title: MyText(
          text: 'Order Details',
          size: 18,
          weight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                title('Order Number'),
                SizedBox(
                  width: Get.width * .3,
                  child: heading(id),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                title('DATE'),
                heading(DateFormat.yMMMd().format(data["created_at"].toDate())),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                title('TOTAL'),
                heading('\$${data["total"]}'),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                title('METHOD'),
                heading(data['method']),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                title('STATUS'),
                heading(data['status']),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                title('Address'),
                heading(data['address']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  MyText heading(String heading) {
    return MyText(
      text: heading,
      size: 18,
      weight: FontWeight.w700,
      overFlow: TextOverflow.fade,
      fontFamily: 'Poppins',
    );
  }

  MyText title(String title) {
    return MyText(
      text: title.toUpperCase(),
      size: 14,
      paddingBottom: 3,
      fontFamily: 'Poppins',
    );
  }
}
