import 'dart:async';

import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:flutter/cupertino.dart';

class AuthNotifier extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  AuthNotifier();

  bool get isLoggedIn => _user != null;

  bool get isLoading => _isLoading;

  Future<void> registerAccount(
    String email,
    String password,
    String name,
    bool agreedToReceiveNews,
  ) async {
    // TODO change register implementation

    _changeLoadingState(true);

    await Future.delayed(Duration(seconds: 4));
    _user = User(0, email, name, password);

    _changeLoadingState(false);
  }

  Future<void> signInWithEmail(
    String email,
    String password,
  ) async {
    // TODO change sign in implementation

    _changeLoadingState(true);

    await Future.delayed(Duration(seconds: 2));
    _user = User(0, email, 'name', password);

    _changeLoadingState(false);
  }

  Future<void> signOut() async {
    // TODO change sign out implementation

    _changeLoadingState(true);

    _changeLoadingState(false);
  }

  void _changeLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}
