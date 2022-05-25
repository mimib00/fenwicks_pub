import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/controller/auth_controller.dart';
import 'package:fenwicks_pub/model/order.dart';
import 'package:fenwicks_pub/model/product.dart';
import 'package:fenwicks_pub/routes/routes.dart';
import 'package:fenwicks_pub/view/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../view/widget/error_card.dart';

class ShopController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("products");

  RxList<Product> products = <Product>[].obs;

  RxList<Order> cart = <Order>[].obs;

  String address = '';

  RxBool isCash = false.obs;

  Map<String, dynamic> orderData = {};

  /// Gets a list of the products.
  void getAllProducts() async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
    try {
      var temp = await _ref.get();
      docs = temp.docs;
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
    for (var doc in docs) {
      products.add(Product.fromJson(doc.data(), doc.id));
    }
    update();
  }

  void addToCart(Product product) {
    cart.add(Order(product, 1));
    update();
  }

  void removeFromCart(Product product) {
    cart.removeWhere((element) => product.id == element.product.id);
    update();
  }

  void changeQuantity(Order order, int ammount) {
    final newOrder = Order(order.product, order.quantity + ammount);
    int index = cart.indexWhere((element) => element.product.id == order.product.id);
    cart[index] = newOrder;
    update();
  }

  double getCartTotal() {
    double price = 0;
    for (var order in cart) {
      price += (order.product.price * order.quantity);
    }
    return price;
  }

  void selectAddress(String addr) => address = addr;

  void selectPayment(bool value) {
    isCash.value = value;
    update();
  }

  /// push an order request.
  void order() async {
    final CollectionReference<Map<String, dynamic>> ref = FirebaseFirestore.instance.collection("orders");
    final AuthController auth = Get.find();
    final user = auth.user.value!;
    List<Map<String, dynamic>> items = [];
    var temp = cart.where((p0) => p0.quantity > 0).toList();
    for (var item in temp) {
      items.add(item.toMap());
    }

    if (!isCash.value) {
      await _useStripe();
      return;
    }

    try {
      Map<String, dynamic> data = {
        "owner": FirebaseFirestore.instance.collection("users").doc(user.id),
        "created_at": FieldValue.serverTimestamp(),
        "address": address,
        "method": "Cash on Delivery",
        "status": "pending",
        "total": getCartTotal(),
        "products": items,
      };

      final order = await ref.add(data);
      final orderInfo = await order.get();
      orderData = {
        "data": orderInfo.data()!,
        "id": orderInfo.id
      };

      auth.updateUserData({
        "orders": FieldValue.arrayUnion([
          ref.doc(orderInfo.id)
        ])
      });

      Get.toNamed(AppLinks.purchaseSuccessful);
    } on FirebaseException catch (e) {
      Get.showSnackbar(errorCard(e.message!));
    }
  }

  /// Show the stripe interface for the product
  Future<void> _useStripe() async {
    Get.dialog(const LoadingCard(), barrierDismissible: false);
    final CollectionReference<Map<String, dynamic>> ref = FirebaseFirestore.instance.collection("orders");
    final AuthController authController = Get.find();
    final user = authController.user.value!;
    List<Map<String, dynamic>> items = [];
    var temp = cart.where((p0) => p0.quantity > 0).toList();
    for (var item in temp) {
      items.add(item.toMap());
    }
    try {
      var response = await http.post(
        Uri.parse('https://europe-west1-fenwicks-pub.cloudfunctions.net/stripePaymentIntentrequest'),
        body: {
          'email': user.email,
          'amount': (getCartTotal().toInt() * 100).toString(),
        },
      );

      final paymentIntentData = jsonDecode(response.body);
      Get.back();
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customerId: paymentIntentData['customer'],
          paymentIntentClientSecret: paymentIntentData['paymentIntent'],
          customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
          applePay: true,
          googlePay: true,
          testEnv: true,
          merchantDisplayName: "Fenwick's Pub",
          merchantCountryCode: "US",
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      // add order to firestore.
      Map<String, dynamic> data = {
        "owner": FirebaseFirestore.instance.collection("users").doc(user.id),
        "created_at": FieldValue.serverTimestamp(),
        "address": address,
        "method": "Debit Card",
        "status": "pending",
        "total": getCartTotal(),
        "products": items,
      };

      final order = await ref.add(data);
      final orderInfo = await order.get();
      orderData = {
        "data": orderInfo.data()!,
        "id": orderInfo.id
      };

      authController.updateUserData({
        "orders": FieldValue.arrayUnion([
          ref.doc(orderInfo.id)
        ])
      });

      // genrate recipt.

      Get.toNamed(AppLinks.purchaseSuccessful);
    } catch (e) {
      if (e is StripeException) {
        Get.showSnackbar(errorCard("Error from Stripe: ${e.error.localizedMessage}"));
      } else {
        Get.showSnackbar(errorCard("Unforeseen error: $e"));
      }
    }
  }
}
