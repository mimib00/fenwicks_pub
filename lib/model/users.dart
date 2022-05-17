import 'package:fenwicks_pub/model/address.dart';

class Users {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final List<AddressModel>? address;
  final List<Map<String, dynamic>> history;
  final int points;

  Users(
    this.name,
    this.email,
    this.phone,
    this.points,
    this.photo,
    this.history, {
    this.id,
    this.address,
  });

  factory Users.fromJson(Map<String, dynamic> data, {String? uid}) {
    final map = data["history"].cast<Map<String, dynamic>>();

    List<AddressModel> addresses = [];
    List? temp = data["address"];
    if (temp != null && temp.isNotEmpty) {
      for (var item in temp) {
        addresses.add(AddressModel.fromJson(item));
      }
    }

    return Users(
      data["name"],
      data["email"],
      data["phone"],
      data["points"] ?? 0,
      data["photo"] ?? '',
      map,
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


// class History{
//   final 
// }