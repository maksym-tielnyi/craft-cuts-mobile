import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/auth/domain/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl implements UserRepository {
  static const _apiEndpoint =
      'craftcutstestapiproject20211011184405.azurewebsites.net';
  static const _unencodedRegisterPath = 'api/Customer/Registration';
  static const _unencodedSignInPath = 'api/Customer/Auth';

  final _client = http.Client();
  final _currentUserController = StreamController<User?>();
  final _errorController = StreamController<Exception?>();

  Stream<User?> get currentUser => _currentUserController.stream;

  Stream<Exception?> get exceptionStream => _errorController.stream;

  @override
  void registerUser(User userData) async {
    final requestUri = Uri.https(_apiEndpoint, _unencodedRegisterPath);
    final bodyJson = userData.toMap();

    try {
      final response = await _client.post(
        requestUri,
        body: bodyJson,
      );
      _processRegisterResponse(response);
    } on Exception catch (e) {
      _errorController.sink.add(e);
      _currentUserController.sink.add(null);
    }
  }

  @override
  void signInWithEmailAndPassword(String email, String password) async {
    final queryParams = {
      'email': email,
      'password': password,
    };

    final requestUri = Uri.https(
      _apiEndpoint,
      _unencodedSignInPath,
      queryParams,
    );

    try {
      final response = await _client.post(requestUri);
      _processSignInResponse(response);
    } on Exception catch (e) {
      _errorController.sink.add(e);
      _currentUserController.sink.add(null);
    }
  }

  @override
  void signOut() {
    _currentUserController.sink.add(null);
  }

  void _processSignInResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      _processSignInResponseOk(response);
    }
  }

  void _processRegisterResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      _processRegisterResponseOK(response);
    }
  }

  void _processSignInResponseOk(http.Response response) {
    final decodedResponse = _parseHttpResponse(response);

    try {
      final user = User.fromJson(decodedResponse);
      _currentUserController.sink.add(user);
    } on Exception catch (e) {
      _processUserAuthenticationError(e);
    }
  }

  void _processRegisterResponseOK(http.Response response) {
    final decodedResponse = _parseHttpResponse(response);

    try {
      final user = User.fromJson(decodedResponse);
      _currentUserController.sink.add(user);
    } on Exception catch (e) {
      _processUserAuthenticationError(e);
    }
  }

  Map<String, dynamic> _parseHttpResponse(http.Response response) {
    final decodedString = utf8.decode(response.bodyBytes);
    return jsonDecode(decodedString) as Map<String, dynamic>;
  }

  void _processUserAuthenticationError(Exception e) {
    _errorController.sink.add(e);
    _currentUserController.sink.add(null);
  }
}
