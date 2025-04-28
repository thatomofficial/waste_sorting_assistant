class User {
  final String id; // Unique identifier for the user
  final String name; // User's name
  final String email; // User's email
  final String? profileImageUrl; // URL to the user's profile picture (optional)
  final List<String> favoriteItems; // List of IDs of favorite waste items
  final DateTime createdAt; // Date and time when the user was created

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
    required this.favoriteItems,
    required this.createdAt,
  });
}
