import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/view/constant/color.dart';
import 'package:fenwicks_pub/view/orders/order_details.dart';
import 'package:fenwicks_pub/view/widget/back_button.dart';
import 'package:fenwicks_pub/view/widget/error_card.dart';
import 'package:fenwicks_pub/view/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<Map<String, dynamic>> orders = [];

  Future<Map<String, dynamic>> getOrderInfo(DocumentReference<Map<String, dynamic>> order) async {
    Map<String, dynamic> data = {};
    String id = "";
    try {
      final temp = await order.get();
      data = temp.data()!;
      id = temp.id;
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }

    return {
      "data": data,
      "id": id
    };
  }

  void init() async {
    final AuthController authController = Get.find();
    final user = authController.user.value!;
    final _orders = user.orders;

    for (var i = 0; i < _orders.length; i++) {
      final data = await getOrderInfo(_orders[i]);
      setState(() {
        orders.add(data);
      });
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: backButton(),
        title: MyText(
          text: 'Order History',
          size: 18,
          weight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _OrderTile(order: order);
        },
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  final Map<String, dynamic> order;
  const _OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = order["data"]["created_at"].toDate();
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
      child: ListTile(
        onTap: () => Get.to(() => OrderDetails(order: order)),
        title: MyText(
          height: 1.1,
          text: "Order: ${order["id"]}",
          size: 17,
          weight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        subtitle: MyText(
          height: 1.1,
          text: "Status: ${order["data"]["status"]}",
          size: 17,
          weight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            MyText(
              height: 1.1,
              text: date.day.toString(),
              size: 37,
              color: kSecondaryColor,
              weight: FontWeight.w900,
              fontFamily: 'Poppins',
            ),
            MyText(
              text: DateFormat.yMMM().format(date),
              size: 9,
              color: kSecondaryColor,
              weight: FontWeight.w700,
              fontFamily: 'Poppins',
            ),
          ],
        ),
      ),
    );
  }
}
