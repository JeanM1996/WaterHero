// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TipsModel {
  TipsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
  final String title;
  final String description;
  final String imageUrl;

  TipsModel copyWith({
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return TipsModel(
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory TipsModel.fromMap(Map<String, dynamic> map) {
    return TipsModel(
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipsModel.fromJson(String source) =>
      TipsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TipsModel(title: $title, description: $description, imageUrl: $imageUrl)';

  @override
  bool operator ==(covariant TipsModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ imageUrl.hashCode;
}
