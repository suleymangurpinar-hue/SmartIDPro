import 'package:flutter/material.dart';

import '../models/auth_user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({AuthService? service}) : _service = service ?? AuthService();

  final AuthService _service;

  AuthUser? _user;
  bool _loading = false;
  String? _error;

  AuthUser? get user => _user;

  bool get loading => _loading;

  bool get isAuthenticated => _user != null;

  String? get error => _error;

  Future<void> load() async {
    _loading = true;
    notifyListeners();

    _user = await _service.currentUser();

    _loading = false;
    notifyListeners();
  }

  Future<bool> signIn({required String email, required String pin}) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await _service.signIn(email: email, pin: pin);
      _loading = false;
      notifyListeners();
      return true;
    } on AuthException catch (error) {
      _error = error.message;
    }

    _loading = false;
    notifyListeners();
    return false;
  }

  Future<void> signOut() async {
    _loading = true;
    notifyListeners();

    await _service.signOut();
    _user = null;

    _loading = false;
    notifyListeners();
  }
}
