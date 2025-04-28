import 'package:flutter/material.dart';
import 'package:waste_sorting_assistant/domain/entities/user.dart';
import 'package:waste_sorting_assistant/domain/repositories/auth_repository.dart';
import 'package:waste_sorting_assistant/domain/usecases/auth/sign_in_usecase.dart';
import 'package:waste_sorting_assistant/domain/usecases/auth/sign_up_usecase.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _repository;
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;

  User? _user;
  bool _isLoading = false;
  String? _error;

  AuthProvider(this._repository)
      : _signInUseCase = SignInUseCase(_repository),
        _signUpUseCase = SignUpUseCase(_repository) {
    _init();
  }

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  Future<void> _init() async {
    _user = await _repository.getCurrentUser();
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    try {
      _user = await _signInUseCase(email, password);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    _setLoading(true);
    try {
      _user = await _signUpUseCase(email, password, name);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _repository.signOut();
      _user = null;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
