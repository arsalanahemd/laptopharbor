// import 'package:cloud_firestore/cloud_firestore.dart';

// class Order {
//   String id;
//   String userId;
//   List<OrderItem> items;
//   double totalAmount;
//   ShippingInfo shippingInfo;
//   String status; // pending, confirmed, processing, shipped, delivered, cancelled
//   DateTime orderDate;
//   PaymentInfo paymentInfo;
//   String? trackingNumber;
//   String? address;
  
//   Order({
//     required this.id,
//     required this.userId,
//     required this.items,
//     required this.totalAmount,
//     required this.shippingInfo,
//     this.status = 'pending',
//     required this.orderDate,
//     required this.paymentInfo,
//     this.trackingNumber,
//     this.address,
//   });
  
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'userId': userId,
//       'items': items.map((item) => item.toMap()).toList(),
//       'totalAmount': totalAmount,
//       'shippingInfo': shippingInfo.toMap(),
//       'status': status,
//       'orderDate': orderDate.toIso8601String(),
//       'paymentInfo': paymentInfo.toMap(),
//       'trackingNumber': trackingNumber,
//       'createdAt': FieldValue.serverTimestamp(),
//     };
//   }
  
//   factory Order.fromMap(Map<String, dynamic> data) {
//     return Order(
//       id: data['id'],
//       userId: data['userId'],
//       items: (data['items'] as List).map((item) => OrderItem.fromMap(item)).toList(),
//       totalAmount: data['totalAmount'].toDouble(),
//       shippingInfo: ShippingInfo.fromMap(data['shippingInfo']),
//       status: data['status'],
//       orderDate: DateTime.parse(data['orderDate']),
//       paymentInfo: PaymentInfo.fromMap(data['paymentInfo']),
//       trackingNumber: data['trackingNumber'],
//     );
//   }
// }

// class OrderItem {
//   String productId;
//   String productName;
//   double price;
//   int quantity;
//   String? imageUrl;
  
//   OrderItem({
//     required this.productId,
//     required this.productName,
//     required this.price,
//     required this.quantity,
//     this.imageUrl,
//   });
  
//   Map<String, dynamic> toMap() {
//     return {
//       'productId': productId,
//       'productName': productName,
//       'price': price,
//       'quantity': quantity,
//       'imageUrl': imageUrl,
//     };
//   }
  
//   factory OrderItem.fromMap(Map<String, dynamic> data) {
//     return OrderItem(
//       productId: data['productId'],
//       productName: data['productName'],
//       price: data['price'].toDouble(),
//       quantity: data['quantity'],
//       imageUrl: data['imageUrl'],
//     );
//   }
// }

// class ShippingInfo {
//   String fullName;
//   String email;
//   String phone;
//   String address;
//   String city;
//   String state;
//   String zipCode;
  
//   ShippingInfo({
//     required this.fullName,
//     required this.email,
//     required this.phone,
//     required this.address,
//     required this.city,
//     required this.state,
//     required this.zipCode,
//   });
  
//   Map<String, dynamic> toMap() {
//     return {
//       'fullName': fullName,
//       'email': email,
//       'phone': phone,
//       'address': address,
//       'city': city,
//       'state': state,
//       'zipCode': zipCode,
//     };
//   }
  
//   factory ShippingInfo.fromMap(Map<String, dynamic> data) {
//     return ShippingInfo(
//       fullName: data['fullName'],
//       email: data['email'],
//       phone: data['phone'],
//       address: data['address'],
//       city: data['city'],
//       state: data['state'],
//       zipCode: data['zipCode'],
//     );
//   }
// }

// class PaymentInfo {
//   String method; // cod, card, upi, etc.
//   String? transactionId;
//   bool isPaid;
  
//   PaymentInfo({
//     required this.method,
//     this.transactionId,
//     this.isPaid = false,
//   });
  
//   Map<String, dynamic> toMap() {
//     return {
//       'method': method,
//       'transactionId': transactionId,
//       'isPaid': isPaid,
//     };
//   }
  
//   factory PaymentInfo.fromMap(Map<String, dynamic> data) {
//     return PaymentInfo(
//       method: data['method'],
//       transactionId: data['transactionId'],
//       isPaid: data['isPaid'] ?? false,
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

// ============ ORDER ITEM ============
class OrderItem {
  String productId;
  String productName;
  double price;
  int quantity;
  String? imageUrl;
  
  OrderItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }
  
  factory OrderItem.fromMap(Map<String, dynamic> data) {
    return OrderItem(
      productId: data['productId']?.toString() ?? '',
      productName: data['productName']?.toString() ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (data['quantity'] as num?)?.toInt() ?? 1,
      imageUrl: data['imageUrl']?.toString(),
    );
  }
}

// ============ SHIPPING INFO ============
class ShippingInfo {
  String fullName;
  String email;
  String phone;
  String address;
  String city;
  String state;
  String zipCode;
  
  ShippingInfo({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
    };
  }
  
  factory ShippingInfo.fromMap(Map<String, dynamic> data) {
    return ShippingInfo(
      fullName: data['fullName']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
      phone: data['phone']?.toString() ?? '',
      address: data['address']?.toString() ?? '',
      city: data['city']?.toString() ?? '',
      state: data['state']?.toString() ?? '',
      zipCode: data['zipCode']?.toString() ?? '',
    );
  }
}

// ============ PAYMENT INFO ============
class PaymentInfo {
  String method;
  String? transactionId;
  bool isPaid;
  
  PaymentInfo({
    required this.method,
    this.transactionId,
    this.isPaid = false,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'method': method,
      'transactionId': transactionId,
      'isPaid': isPaid,
    };
  }
  
  factory PaymentInfo.fromMap(Map<String, dynamic> data) {
    return PaymentInfo(
      method: data['method']?.toString() ?? 'cod',
      transactionId: data['transactionId']?.toString(),
      isPaid: (data['isPaid'] as bool?) ?? false,
    );
  }
}

// ============ ORDER ============
class Order {
  String id;
  String userId;
  List<OrderItem> items;
  double totalAmount;
  ShippingInfo shippingInfo;
  String status;
  DateTime orderDate;
  PaymentInfo paymentInfo;
  String? trackingNumber;
  
  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.shippingInfo,
    this.status = 'pending',
    required this.orderDate,
    required this.paymentInfo,
    this.trackingNumber,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'shippingInfo': shippingInfo.toMap(),
      'status': status,
      'orderDate': orderDate.toIso8601String(),
      'paymentInfo': paymentInfo.toMap(),
      'trackingNumber': trackingNumber,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
  
  factory Order.fromMap(Map<String, dynamic> data) {
    // Parse date from Firestore
    DateTime parseDate(dynamic dateValue) {
      if (dateValue == null) return DateTime.now();
      
      if (dateValue is String) {
        try {
          return DateTime.parse(dateValue);
        } catch (e) {
          return DateTime.now();
        }
      } else if (dateValue is Timestamp) {
        return dateValue.toDate();
      } else if (dateValue is DateTime) {
        return dateValue;
      } else {
        return DateTime.now();
      }
    }
    
    return Order(
      id: data['id']?.toString() ?? '',
      userId: data['userId']?.toString() ?? '',
      items: (data['items'] as List<dynamic>? ?? [])
          .map<OrderItem>((item) => OrderItem.fromMap(item))
          .toList(),
      totalAmount: (data['totalAmount'] as num?)?.toDouble() ?? 0.0,
      shippingInfo: ShippingInfo.fromMap(data['shippingInfo'] ?? {}),
      status: data['status']?.toString() ?? 'pending',
      orderDate: parseDate(data['orderDate']),
      paymentInfo: PaymentInfo.fromMap(data['paymentInfo'] ?? {}),
      trackingNumber: data['trackingNumber']?.toString(),
    );
  }
}