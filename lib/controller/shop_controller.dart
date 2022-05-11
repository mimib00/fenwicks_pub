import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/model/product.dart';
import 'package:get/get.dart';

import '../view/widget/error_card.dart';

class ShopController extends GetxController {
  final CollectionReference<Map<String, dynamic>> _ref = FirebaseFirestore.instance.collection("products");

  RxList<Product> products = <Product>[].obs;

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
}
