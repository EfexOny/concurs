import 'dart:convert';

class Brands {
  final String? image;
  Brands({
    this.image,
  });

  Brands copyWith({
    String? image,
  }) {
    return Brands(
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
    };
  }

  factory Brands.fromMap(Map<String, dynamic> map) {
    return Brands(
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Brands.fromJson(String source) => Brands.fromMap(json.decode(source));

  @override
  String toString() => 'Brands(image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Brands && other.image == image;
  }

  @override
  int get hashCode => image.hashCode;
}
