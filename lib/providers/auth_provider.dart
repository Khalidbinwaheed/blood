import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blood/services/auth_service.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  unauthenticated,
  loading,
  error,
}

class AuthProvider extends ChangeNotifier {
  AuthStatus _status = AuthStatus.uninitialized;
  AuthStatus get status => _status;

  User? _user;
  User? get user => _user;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final AuthService _authService = AuthService();

  AuthProvider() {
    _authService.auth.authStateChanges().listen((user) {
      _user = user;
      _status =
          user == null ? AuthStatus.unauthenticated : AuthStatus.authenticated;
      notifyListeners();
    });
  }

  Future<void> signUp(String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      await _authService.signUpWithEmailAndPassword(email, password);
      _status = AuthStatus.authenticated; // Listener will handle this
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      _status = AuthStatus.authenticated; // Listener will handle this
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _status = AuthStatus.loading;
    notifyListeners();
    await _authService.signOut();
    _status = AuthStatus.unauthenticated; // Listener will handle this
    notifyListeners();
  }
}
