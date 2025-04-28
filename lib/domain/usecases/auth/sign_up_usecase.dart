import 'package:waste_sorting_assistant/domain/entities/user.dart';
import 'package:waste_sorting_assistant/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<User?> call(String email, String password, String name) async {
    return await _repository.signUp(email, password, name);
  }
}
