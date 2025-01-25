import '../../domain/entities/waste_item.dart';

class WasteItemModel extends WasteItem {
  const WasteItemModel({
    required String id,
    required String name,
    required String category,
    required String description,
    required String disposalMethod,
    required String imageUrl,
  }) : super(
    id: id,
    name: name,
    category: category,
    description: description,
    disposalMethod: disposalMethod,
    imageUrl: imageUrl,
  );

  /// Converts a JSON object into a WasteItemModel
  factory WasteItemModel.fromJson(Map<String, dynamic> json) {
    return WasteItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      disposalMethod: json['disposal_method'] as String,
      imageUrl: json['image_url'] as String? ?? '', // Default to empty string if null
    );
  }

  /// Converts a WasteItemModel into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'disposal_method': disposalMethod,
      'image_url': imageUrl,
    };
  }

  /// Converts a Firebase document snapshot into a WasteItemModel
  factory WasteItemModel.fromFirestore(Map<String, dynamic> doc) {
    return WasteItemModel.fromJson(doc);
  }

  /// Converts a WasteItemModel into a Firebase-compatible map
  Map<String, dynamic> toFirestore() {
    return toJson();
  }
}
