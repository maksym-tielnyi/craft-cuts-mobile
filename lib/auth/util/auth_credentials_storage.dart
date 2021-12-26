import 'package:craft_cuts_mobile/auth/data/models/stored_user_credentials.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthCredentialsStorage {
  static const _loginKey = 'login';
  static const _passwordKey = 'password';

  const AuthCredentialsStorage();

  Future<StoredUserCredentials> get savedCredentials async {
    final storage = FlutterSecureStorage();
    final login = await storage.read(key: _loginKey);
    final password = await storage.read(key: _passwordKey);
    return StoredUserCredentials(login, password);
  }

  Future<bool> saveCredentials(StoredUserCredentials credentials) async {
    if (!credentials.isValid) return false;
    final storage = FlutterSecureStorage();
    final loginSaveFuture =
        storage.write(key: _loginKey, value: credentials.login);
    final passwordSaveFuture =
        storage.write(key: _passwordKey, value: credentials.password);

    bool caughtErrors = false;
    await Future.wait([loginSaveFuture, passwordSaveFuture], eagerError: true)
        .catchError(
      (error) {
        caughtErrors = true;
      },
    );
    return caughtErrors;
  }
}
