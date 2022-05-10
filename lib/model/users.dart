class Users {
  final String? id;
  final String name;
  final String email;
  final String phone;

  Users(
    this.name,
    this.email,
    this.phone, {
    this.id,
  });

  factory Users.fromJson(Map<String, dynamic> data, {String? uid}) => Users(
        data["name"],
        data["email"],
        data["phone"],
        id: uid,
      );
}
