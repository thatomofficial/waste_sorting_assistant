import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waste_sorting_assistant/data/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUser(String userId) async {
    try {
      final docSnapshot = await _firestore.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        return UserModel.fromFirestore(docSnapshot.data()!);
      }
      return null;
    } catch (e) {
      return null; // Handle errors
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      // Handle errors
    }
  }
}
