import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required String super.profileImageUrl,
    required super.favoriteItems,
    required super.createdAt,
  });

  /// Converts a JSON object into a UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profile_image_url'] as String? ?? '',
      favoriteItems: List<String>.from(json['favorite_items'] ?? []),
      createdAt: DateTime.parse(json['created_at'] as String),

    );
  }

  /// Converts a UserModel into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_image_url': profileImageUrl,
      'favorite_items': favoriteItems,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Converts a Firebase document snapshot into a UserModel
  factory UserModel.fromFirestore(Map<String, dynamic> doc) {
    return UserModel.fromJson(doc);
  }

  /// Converts a UserModel into a Firebase-compatible map
  Map<String, dynamic> toFirestore() {
    return toJson();
  }
}
