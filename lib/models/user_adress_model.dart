class UserAddress {
  String? id;
  String userId;
  String fullName;
  String phone;
  String address;
  String city;
  String? landmark;
  bool isDefault;
  
  UserAddress({
    this.id,
    required this.userId,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.city,
    this.landmark,
    this.isDefault = false,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'phone': phone,
      'address': address,
      'city': city,
      'landmark': landmark,
      'isDefault': isDefault,
    };
  }
  
  factory UserAddress.fromMap(String id, Map<String, dynamic> map) {
    return UserAddress(
      id: id,
      userId: map['userId'],
      fullName: map['fullName'],
      phone: map['phone'],
      address: map['address'],
      city: map['city'],
      landmark: map['landmark'],
      isDefault: map['isDefault'] ?? false,
    );
  }
}