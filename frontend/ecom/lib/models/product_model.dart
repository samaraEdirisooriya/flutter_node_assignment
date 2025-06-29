class Product {
  final int id;
  final String name;
  final int price;
  final int quantity;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    price: json['price'],
    quantity: json['quantity'],
    image: json['image'],
  );
}
