import 'dart:async';

import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/auth/domain/repositories/exceptions/auth_response_exception.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/params/register_user_param.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/params/signin_param.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/register_user_usecase.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/signin_usecase.dart';
import 'package:craft_cuts_mobile/auth/presentation/view_models/sign_in_state_viewmodel.dart';
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

  var _signInStateViewModel = SignInStateViewModel(null);

  SignInStateViewModel get signInStateViewModel => _signInStateViewModel;

  Future<void> registerAccount(
    String email,
    String password,
    String name,
    String phone,
    bool agreedToReceiveNews,
  ) async {
    _handleAuthError(null);
    _changeLoadingState(true);

    try {
      await _registerUserUsecase(
        RegisterUserParam(
          User(null, email, name, password, phone),
        ),
      );
    } on AuthResponseException catch (e) {
      _handleAuthError(e);
    } finally {
      _changeLoadingState(false);
    }
  }

  Future<void> signInWithEmail(
    String email,
    String password,
  ) async {
    _handleAuthError(null);
    _changeLoadingState(true);

    try {
      await _signInUsecase(SignInParam(email, password));
    } on AuthResponseException catch (e) {
      _handleAuthError(e);
    } finally {
      _changeLoadingState(false);
    }
  }

  Future<void> signOut() async {
    _handleAuthError(null);
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
    if (user != null) {
      _handleAuthError(null);
    }
    notifyListeners();
  }

  void _handleAuthError(Exception? exception) {
    _signInStateViewModel = SignInStateViewModel(exception);
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }
}
