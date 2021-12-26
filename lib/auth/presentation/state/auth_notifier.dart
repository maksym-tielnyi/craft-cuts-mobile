import 'dart:async';

import 'package:craft_cuts_mobile/auth/data/models/stored_user_credentials.dart';
import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/auth/domain/repositories/exceptions/auth_response_exception.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/params/register_user_param.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/params/signin_param.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/register_user_usecase.dart';
import 'package:craft_cuts_mobile/auth/domain/usecases/signin_usecase.dart';
import 'package:craft_cuts_mobile/auth/presentation/view_models/sign_in_state_viewmodel.dart';
import 'package:craft_cuts_mobile/auth/util/auth_credentials_storage.dart';
import 'package:flutter/cupertino.dart';

class AuthNotifier extends ChangeNotifier {
  final RegisterUserUsecase _registerUserUsecase;
  final SignInUsecase _signInUsecase;

  User? _user;
  bool _isLoading = true;

  late StreamSubscription _userSubscription;

  AuthNotifier(
    this._registerUserUsecase,
    this._signInUsecase,
  );

  User? get currentUser => _user;

  bool get isLoggedIn => _user != null;

  bool get isLoading => _isLoading;

  var _signInStateViewModel = SignInStateViewModel(null);

  SignInStateViewModel get signInStateViewModel => _signInStateViewModel;

  Future<void> registerAccount(
    String email,
    String password,
    String name,
    String phone,
    DateTime birthday,
    bool agreedToReceiveNews,
  ) async {
    if (_isLoading) return;
    _handleAuthError(null);
    _changeLoadingState(true);

    try {
      await _registerUserUsecase(
        RegisterUserParam(
          User(null, email, name, password, phone, birthday),
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
    if (_isLoading) return;
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

  Future<void> subscribeToAuthUpdates(Stream<User?> userStream) async {
    _userSubscription = userStream.listen(_userStreamListener);
    await _trySignInWithStoredCredentials();
  }

  Future<void> _trySignInWithStoredCredentials() async {
    final credentialsStorage = AuthCredentialsStorage();
    StoredUserCredentials savedCredentials;
    try {
      savedCredentials = await credentialsStorage.savedCredentials;
      if (savedCredentials.isValid) {
        _signInUsecase(
            SignInParam(savedCredentials.login!, savedCredentials.password!));
      }
    } finally {
      _changeLoadingState(false);
    }
  }

  void _changeLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<void> _userStreamListener(User? user) async {
    _user = user;
    if (user != null) {
      _handleAuthError(null);
      AuthCredentialsStorage()
          .saveCredentials(StoredUserCredentials(user.email, user.password));
    }
    notifyListeners();
  }

  void _handleAuthError(Exception? exception) {
    print(exception.toString());
    _signInStateViewModel = SignInStateViewModel(exception);
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }
}
