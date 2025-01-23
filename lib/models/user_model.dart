class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final String? phoneNumber;
  final String? address;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.phoneNumber,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
