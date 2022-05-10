import 'package:fenwicks_pub/model/address.dart';

class Users {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final List<AddressModel>? address;

  Users(
    this.name,
    this.email,
    this.phone, {
    this.id,
    this.address,
  });

  factory Users.fromJson(Map<String, dynamic> data, {String? uid}) {
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
      address: addresses,
      id: uid,
    );
  }

  toMap() => {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
      };
}
