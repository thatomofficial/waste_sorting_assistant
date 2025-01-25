import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waste_sorting_assistant/data/models/waste_item_model.dart';

class WasteItemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch waste items
  Future<List<WasteItemModel>> getWasteItems() async {
    try {
      final snapshot = await _firestore.collection('waste_items').get();
      return snapshot.docs
          .map((doc) => WasteItemModel.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      return []; // Handle errors
    }
  }

  // Add waste item
  Future<void> addWasteItem(WasteItemModel wasteItem) async {
    try {
      await _firestore.collection('waste_items').add(wasteItem.toJson());
    } catch (e) {
      // Handle errors
    }
  }
}
