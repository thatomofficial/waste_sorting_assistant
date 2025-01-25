class WasteItem {
  final String id; // Unique identifier for the waste item
  final String name; // Name of the waste item (e.g., "Plastic Bottle")
  final String category; // Category of the waste (e.g., "Recyclable", "Organic")
  final String description; // Brief description of the item
  final String disposalMethod; // Recommended disposal method
  final String imageUrl; // URL to an image of the item (optional)

  const WasteItem({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.disposalMethod,
    required this.imageUrl,
  });
}
