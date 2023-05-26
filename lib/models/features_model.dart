import 'dart:convert';

class Features {
  final String? image;
  final String? label;
  Features({
    this.image,
    this.label,
  });

  Features copyWith({
    String? image,
    String? label,
  }) {
    return Features(
      image: image ?? this.image,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'label': label,
    };
  }

  factory Features.fromMap(Map<String, dynamic> map) {
    return Features(
      image: map['image'],
      label: map['label'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Features.fromJson(String source) =>
      Features.fromMap(json.decode(source));

  @override
  String toString() => 'Features(image: $image, label: $label)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Features && other.image == image && other.label == label;
  }

  @override
  int get hashCode => image.hashCode ^ label.hashCode;
}
