class Users {
  final String? id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final List<Map<String, dynamic>> address;
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
    this.address = const [],
  });

  factory Users.fromJson(Map<String, dynamic> data, {String? uid}) {
    final map = data["history"] == null ? <Map<String, dynamic>>[] : data["history"].cast<Map<String, dynamic>>();

    List<Map<String, dynamic>> addresses = data["address"].cast<Map<String, dynamic>>();

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
