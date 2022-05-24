import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/model/product.dart';

class Order {
  final Product product;
  final int quantity;

  Order(this.product, this.quantity);

  Map<String, dynamic> toMap() => {
        "product": FirebaseFirestore.instance.collection("products").doc(product.id),
        "quantity": quantity,
      };
}
