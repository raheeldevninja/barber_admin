import 'dart:io';

class Staff {
  String name;
  File image;

  Staff({
    required this.name,
    required this.image,
  });

  Staff copyWith({
    String? name,
    File? image,
  }) {
    return Staff(
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

}
