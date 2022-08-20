import 'dart:convert';
class NewsModel {
  final int? id;
  final String title;
  final String description;
  final String image;
  final DateTime datePublish;
  final DateTime? dateUpdate;

  NewsModel(
    this.id,
    this.title,
    this.description,
    this.image,
    this.datePublish,
    this.dateUpdate,
  );

  NewsModel copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    DateTime? datePublish,
    DateTime? dateUpdate,
  }) {
    return NewsModel(
      id ?? this.id,
      title ?? this.title,
      description ?? this.description,
      image ?? this.image,
      datePublish ?? this.datePublish,
      dateUpdate ?? this.dateUpdate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'datePublish': datePublish.millisecondsSinceEpoch,
      'dateUpdate': dateUpdate?.millisecondsSinceEpoch,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      map['id'] ?? '',
      map['title'] as String,
      map['description'] as String,
      map['image'] as String,
      DateTime.fromMillisecondsSinceEpoch(map['datePublish']),
      map['dateUpdate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateUpdate']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) => NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, description: $description, image: $image, datePublish: $datePublish, dateUpdate: $dateUpdate)';
  }

  @override
  bool operator ==(covariant NewsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.image == image &&
      other.datePublish == datePublish &&
      other.dateUpdate == dateUpdate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      image.hashCode ^
      datePublish.hashCode ^
      dateUpdate.hashCode;
  }
}
