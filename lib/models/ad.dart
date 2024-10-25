class Ad {
  final String id;
  final String userName;
  final String profilePic;
  final String address;
  final String price;
  final String date;
  final String shift;
  final String additionalInfo;

  Ad({
    required this.id,
    required this.userName,
    required this.profilePic,
    required this.address,
    required this.price,
    required this.date,
    required this.shift,
    required this.additionalInfo,
  });

  @override
  String toString() {
    return 'Ad(id: $id, userName: $userName, address: $address, price: $price, date: $date, shift: $shift, additionalInfo: $additionalInfo)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'profilePic': profilePic,
      'address': address,
      'price': price,
      'date': date,
      'shift': shift,
      'additionalInfo': additionalInfo,
    };
  }

  factory Ad.fromMap(Map<String, dynamic> map) {
    return Ad(
      id: map['id'],
      userName: map['userName'],
      profilePic: map['profilePic'],
      address: map['address'],
      price: map['price'],
      date: map['date'],
      shift: map['shift'],
      additionalInfo: map['additionalInfo'],
    );
  }
}
