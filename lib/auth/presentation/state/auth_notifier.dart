import 'dart:async';

import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/params/register_user_param.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/params/signin_param.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/register_user_usecase.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/signin_usecase.dart';
import 'package:flutter/cupertino.dart';

class AuthNotifier extends ChangeNotifier {
  final RegisterUserUsecase _registerUserUsecase;
  final SignInUsecase _signInUsecase;

  User? _user;
  bool _isLoading = false;

  late StreamSubscription _userSubscription;

  AuthNotifier(
    this._registerUserUsecase,
    this._signInUsecase,
  );

  bool get isLoggedIn => _user != null;

  bool get isLoading => _isLoading;

  Future<void> registerAccount(
    String email,
    String password,
    String name,
    String phone,
    bool agreedToReceiveNews,
  ) async {
    _changeLoadingState(true);
    await _registerUserUsecase(
      RegisterUserParam(
        User(null, email, name, password, phone),
      ),
    );
    _changeLoadingState(false);
  }

  Future<void> signInWithEmail(
    String email,
    String password,
  ) async {
    _changeLoadingState(true);
    await _signInUsecase(SignInParam(email, password));
    _changeLoadingState(false);
  }

  Future<void> signOut() async {
    _changeLoadingState(true);
    // TODO implement sign out
    _changeLoadingState(false);
  }

  void subscribeToAuthUpdates(Stream<User?> userStream) {
    _userSubscription = userStream.listen(_userStreamListener);
  }

  void _changeLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _userStreamListener(User? user) {
    _user = user;
    notifyListeners();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }
}
