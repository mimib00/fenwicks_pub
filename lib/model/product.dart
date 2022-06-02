class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int level;
  final int rating;
  final int servings;
  final int points;
  final int bounus;
  final int qty;

  Product(
    this.id,
    this.name,
    this.description,
    this.price,
    this.level,
    this.rating,
    this.servings,
    this.qty,
    this.points,
    this.bounus,
  );

  factory Product.fromJson(Map<String, dynamic> data, String uid) {
    return Product(
      uid,
      data["name"],
      data["description"],
      double.parse(data["price"].toString()),
      data["level"],
      data["rating"],
      data["servings"],
      data["quantity"],
      int.parse(data["points"].toString()),
      int.parse(data["bounus"].toString()),
    );
  }

  Map<String, dynamic> toMap() => {};
}
