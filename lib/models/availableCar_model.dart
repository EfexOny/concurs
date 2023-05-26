import 'dart:convert';

class AvailableCar {
  String? image;
  String? modelName;
  String? year;
  String? gearType;
  String? seats;
  String? price;

  AvailableCar({
    this.image,
    this.modelName,
    this.year,
    this.gearType,
    this.seats,
    this.price,
  });

  AvailableCar copyWith({
    String? image,
    String? modelName,
    String? year,
    String? gearType,
    String? seats,
    String? price,
  }) {
    return AvailableCar(
      image: image ?? this.image,
      modelName: modelName ?? this.modelName,
      year: year ?? this.year,
      gearType: gearType ?? this.gearType,
      seats: seats ?? this.seats,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'modelName': modelName,
      'year': year,
      'gearType': gearType,
      'seats': seats,
      'price': price,
    };
  }

  factory AvailableCar.fromMap(Map<String, dynamic> map) {
    return AvailableCar(
      image: map['image'],
      modelName: map['modelName'],
      year: map['year'],
      gearType: map['gearType'],
      seats: map['seats'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailableCar.fromJson(String source) =>
      AvailableCar.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AvailableCar(image: $image, modelName: $modelName, year: $year, gearType: $gearType, seats: $seats, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AvailableCar &&
        other.image == image &&
        other.modelName == modelName &&
        other.year == year &&
        other.gearType == gearType &&
        other.seats == seats &&
        other.price == price;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        modelName.hashCode ^
        year.hashCode ^
        gearType.hashCode ^
        seats.hashCode ^
        price.hashCode;
  }
}
