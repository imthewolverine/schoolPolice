class Ad {
  final String id;
  final String userId; // New field for the user ID of the person who placed the ad
  final String userName;
  final String profilePic;
  final String address;
  final String price;
  final String date;
  final String shift;
  final String additionalInfo;
  final int views;
  final int requestCount; // New field for request count

  Ad({
    required this.id,
    required this.userId, // Include userId in the constructor
    required this.userName,
    required this.profilePic,
    required this.address,
    required this.price,
    required this.date,
    required this.shift,
    required this.additionalInfo,
    this.views = 0,
    this.requestCount = 0, // Default value of 0
  });

  // Updated toMap method to include userId
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId, // Include userId in the map
      'userName': userName,
      'profilePic': profilePic,
      'address': address,
      'price': price,
      'date': date,
      'shift': shift,
      'additionalInfo': additionalInfo,
      'views': views,
      'requestCount': requestCount, // Include requestCount in map
    };
  }

  // Updated fromMap factory to include userId
  factory Ad.fromMap(Map<String, dynamic> map) {
    return Ad(
      id: map['id'],
      userId: map['userId'], // Retrieve userId from the map
      userName: map['userName'],
      profilePic: map['profilePic'],
      address: map['address'],
      price: map['price'],
      date: map['date'],
      shift: map['shift'],
      additionalInfo: map['additionalInfo'],
      views: map['views'] ?? 0,
      requestCount: map['requestCount'] ?? 0, // Default to 0 if missing
    );
  }
}
