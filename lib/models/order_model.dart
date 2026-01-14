class OrderModel {
  String? orderId;
  String userId;
  String email;
  String phone;
  String address;
  List<CartItem> items;
  double totalAmount;
  DateTime orderDate;
  String status; // 'pending', 'confirmed', 'shipped', 'delivered', 'cancelled'
  String? paymentMethod;
  String? transactionId;
  
  OrderModel({
    this.orderId,
    required this.userId,
    required this.email,
    required this.phone,
    required this.address,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.status = 'pending',
    this.paymentMethod,
    this.transactionId,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'phone': phone,
      'address': address,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
    };
  }
  
  factory OrderModel.fromMap(String id, Map<String, dynamic> map) {
    return OrderModel(
      orderId: id,
      userId: map['userId'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      items: List<CartItem>.from(
        map['items'].map((x) => CartItem.fromMap(x))
      ),
      totalAmount: map['totalAmount'],
      orderDate: DateTime.parse(map['orderDate']),
      status: map['status'],
      paymentMethod: map['paymentMethod'],
      transactionId: map['transactionId'],
    );
  }
}

class CartItem {
  String productId;
  String name;
  double price;
  int quantity;
  String? imageUrl;
  
  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }
  
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      imageUrl: map['imageUrl'],
    );
  }
}