class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final int level;
  final int rating;
  final int servings;
  final int points;
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
      data["points"],
    );
  }

  Map<String, dynamic> toMap() => {};
}
