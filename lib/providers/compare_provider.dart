import 'package:flutter/material.dart';
import '../models/laptop_model.dart';

class CompareProvider with ChangeNotifier {
  LaptopModel? _firstLaptop;
  LaptopModel? _secondLaptop;

  LaptopModel? get firstLaptop => _firstLaptop;
  LaptopModel? get secondLaptop => _secondLaptop;

  /// Select laptop from search or card
  void selectLaptop(LaptopModel laptop) {
    if (_firstLaptop == null) {
      _firstLaptop = laptop;
    } else if (_secondLaptop == null && _firstLaptop!.id != laptop.id) {
      _secondLaptop = laptop;
    }
    notifyListeners();
  }

  void setFirstLaptop(LaptopModel laptop) {
    _firstLaptop = laptop;
    notifyListeners();
  }

  void setSecondLaptop(LaptopModel laptop) {
    _secondLaptop = laptop;
    notifyListeners();
  }

  void clearCompare() {
    _firstLaptop = null;
    _secondLaptop = null;
    notifyListeners();
  }

  bool get isReady => _firstLaptop != null && _secondLaptop != null;
}
