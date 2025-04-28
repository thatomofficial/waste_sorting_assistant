import 'package:waste_sorting_assistant/domain/entities/user.dart';
import 'package:waste_sorting_assistant/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<User?> call(String email, String password) async {
    return await _repository.signIn(email, password);
  }
}
