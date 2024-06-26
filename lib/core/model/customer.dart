class Customer {

  String? name;
  String? image;
  String? email;
  String? phone;

  Customer({
    required this.name,
    required this.image,
    required this.email,
    required this.phone,
  });

  Customer copyWith({
    String? name,
    String? image,
    String? email,
    String? phone,
  }) {
    return Customer(
      name: name ?? this.name,
      image: image ?? this.image,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

}