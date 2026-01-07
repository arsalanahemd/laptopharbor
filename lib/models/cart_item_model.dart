// import 'laptop_model.dart';

// class CartItem {
//   final LaptopModel laptop;
//   int quantity;

//   CartItem({
//     required this.laptop,
//     this.quantity = 1, required Null Function(dynamic qty) onQuantityChanged, required Null Function() onRemove,
//   });

//   double get totalPrice => laptop.price * quantity;
// }
import 'laptop_model.dart';

class CartItem {
  final LaptopModel laptop;
  int quantity;

  CartItem({
    required this.laptop,
    this.quantity = 1,
  });

  double get totalPrice => laptop.price * quantity;
}
