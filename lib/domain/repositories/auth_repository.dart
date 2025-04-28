import 'package:waste_sorting_assistant/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> signUp(String email, String password, String name);
  Future<User?> signIn(String email, String password);
  Future<void> signOut();
  Future<User?> getCurrentUser();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> updateUserProfile(String name, String? photoUrl);
  Stream<User?> get authStateChanges;
}
