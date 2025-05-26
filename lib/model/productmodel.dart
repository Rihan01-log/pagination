class Productmodel {
  List<Product> product;
  int? total;
  int? skip;
  int? limit;

  Productmodel({
    required this.product,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory Productmodel.fromJson(Map<String, dynamic> json) {
    return Productmodel(
      product:
          (json["products"] as List).map((e) => Product.fromJson(e)).toList(),
      total: json['total'],
      skip: json["skip"],
      limit: json["limit"],
    );
  }
}

class Product {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? sku;
  int? weight;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  String? returnPolicy;
  int? minimumOrderQuantity;
  List<String> images;
  String? thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json["description"],
      category: json["category"],
      price: json["price"],
      discountPercentage: json["discountPercentage"],
      rating: json["rating"],
      stock: json["stock"],
      brand: json["brand"],
      sku: json["sku"],
      weight: json["weight"],
      warrantyInformation: json["warrantyInformation"],
      shippingInformation: json["shippingInformation"],
      availabilityStatus: json['availabilityStatus'],
      returnPolicy: json['returnPolicy'],
      images: List<String>.from(json['images']),
      minimumOrderQuantity: json['minimumOrderQuantity'],
      thumbnail: json['thumbnail'],
    );
  }
}
