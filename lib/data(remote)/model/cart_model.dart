class CartDataModel {
  final bool status;
  final String message;
  final List<CartModel> data;

  CartDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CartModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class CartModel {
  final int id;
  final int productId;
  final String name;
  final String price;
  final int quantity;
  final String image;

  CartModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? '0',
      quantity: json['quantity'] ?? 0,
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }
}
