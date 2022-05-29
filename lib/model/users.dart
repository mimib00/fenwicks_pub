import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenwicks_pub/model/post.dart';

class Users {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final List<Map<String, dynamic>> address;
  final List<Map<String, dynamic>> history;
  final List<DocumentReference<Map<String, dynamic>>> orders;
  final List<DocumentReference<Map<String, dynamic>>> posts;
  final int points;

  Users(
    this.name,
    this.email,
    this.phone,
    this.points,
    this.photo,
    this.history,
    this.orders,
    this.posts, {
    this.id,
    this.address = const [],
  });

  factory Users.fromJson(Map<String, dynamic> data, {String? uid}) {
    final map = data["history"] == null ? <Map<String, dynamic>>[] : data["history"].cast<Map<String, dynamic>>();
    final order = data["orders"] == null ? <DocumentReference<Map<String, dynamic>>>[] : data["orders"].cast<DocumentReference<Map<String, dynamic>>>();
    List<Map<String, dynamic>> addresses = data["address"].cast<Map<String, dynamic>>();

    return Users(
      data["name"],
      data["email"],
      data["phone"],
      data["points"] ?? 0,
      data["photo"] ?? '',
      map,
      order,
      data["posts"].cast<DocumentReference<Map<String, dynamic>>>(),
      address: addresses,
      id: uid,
    );
  }

  toMap() => {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "points": points,
        "photo": photo,
        "history": history,
      };
}
