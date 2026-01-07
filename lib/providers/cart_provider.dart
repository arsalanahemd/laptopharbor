// import 'package:flutter/material.dart';
// import '../models/cart_item_model.dart';
// import '../models/laptop_model.dart';

// class CartProvider with ChangeNotifier {
//   final List<CartItem> _items = [];

//   List<CartItem> get items => _items;

//   double get totalAmount =>
//       _items.fold(0, (sum, item) => sum + item.totalPrice);

//   void addToCart(LaptopModel laptop) {
//     final index =
//         _items.indexWhere((item) => item.laptop.id == laptop.id);

//     if (index >= 0) {
//       _items[index].quantity++;
//     } else {
//       _items.add(CartItem(laptop: laptop, onQuantityChanged: (qty) {  }, onRemove: () {  }));
//     }
//     notifyListeners();
//   }

//   void updateQuantity(LaptopModel laptop, int quantity) {
//     if (quantity <= 0) {
//       removeFromCart(laptop);
//     } else {
//       final index =
//           _items.indexWhere((item) => item.laptop.id == laptop.id);
//       _items[index].quantity = quantity;
//     }
//     notifyListeners();
//   }

//   void removeFromCart(LaptopModel laptop) {
//     _items.removeWhere((item) => item.laptop.id == laptop.id);
//     notifyListeners();
//   }

//   void clearCart() {
//     _items.clear();
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/laptop_model.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  // Add to cart
  void addToCart(LaptopModel laptop) {
    final index =
        _items.indexWhere((item) => item.laptop.id == laptop.id);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(laptop: laptop));
    }
    notifyListeners();
  }

  // Update quantity
  void updateQuantity(LaptopModel laptop, int quantity) {
    final index =
        _items.indexWhere((item) => item.laptop.id == laptop.id);

    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  // Remove item
  void removeFromCart(LaptopModel laptop) {
    _items.removeWhere((item) => item.laptop.id == laptop.id);
    notifyListeners();
  }

  // Total amount
  double get totalAmount =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  get totalItems => null;

  void clearCart() {}
}
