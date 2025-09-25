class OrderDataModel {
  final bool status;
  final String message;
  final List<OrderModel> orders;

  OrderDataModel({
    required this.status,
    required this.message,
    required this.orders,
  });

  factory OrderDataModel.fromJson(Map<String, dynamic> json) {
    return OrderDataModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      orders: (json["orders"] as List<dynamic>? ?? [])
          .map((e) => OrderModel.fromJson(e))
          .toList(),
    );
  }
}

class OrderModel {
  final int id;
  final String totalAmount;
  final String orderNumber;
  final String status;
  final String createdAt;
  final List<ItemModel> products;

  OrderModel({
    required this.id,
    required this.totalAmount,
    required this.orderNumber,
    required this.status,
    required this.createdAt,
    required this.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"] ?? 0,
      totalAmount: json["total_amount"] ?? "0.0",
      orderNumber: json["order_number"] ?? "",
      status: json["status"] ?? "",
      createdAt: json["created_at"] ?? "",
      products: (json["product"] as List<dynamic>? ?? [])
          .map((e) => ItemModel.fromJson(e))
          .toList(),
    );
  }
}

class ItemModel {
  final int id;
  final String name;
  final int quantity;
  final String price;
  final String image;

  ItemModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      quantity: json["quantity"] ?? 0,
      price: json["price"] ?? "0.0",
      image: json["image"] ?? "",
    );
  }
}
