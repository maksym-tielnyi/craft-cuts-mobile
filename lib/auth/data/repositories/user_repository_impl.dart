import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/auth/domain/repositories/exceptions/auth_response_exception.dart';
import 'package:craft_cuts_mobile/auth/domain/repositories/user_repository.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl implements UserRepository {
  static const _apiEndpoint =
      'craftcutstestapiproject20211011184405.azurewebsites.net';
  static const _unencodedRegisterPath = 'api/Customer/Registration';
  static const _unencodedSignInPath = 'api/Customer/Auth';

  final _client = http.Client();
  final _currentUserController = StreamController<User?>();

  Stream<User?> get currentUser => _currentUserController.stream;

  @override
  void registerUser(User userData) async {
    final requestUri = Uri.https(_apiEndpoint, _unencodedRegisterPath);
    final bodyJson = userData.toMap();

    final response = await _client.post(
      requestUri,
      body: bodyJson,
    );
    _processRegisterResponse(response);
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

    final response = await _client.post(requestUri);
    _processSignInResponse(response);
  }

  @override
  void signOut() {
    _currentUserController.sink.add(null);
  }

  void _processSignInResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      _processSignInResponseOk(response);
    } else if (response.statusCode == HttpStatus.notFound) {
      _processStatusCode404NotFound(response);
    } else {
      throw AuthResponseException(response.statusCode.toString());
    }
  }

  void _processRegisterResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      _processRegisterResponseOK(response);
    } else if (response.statusCode == HttpStatus.notFound) {
      _processStatusCode404NotFound(response);
    } else {
      throw AuthResponseException(response.statusCode.toString());
    }
  }

  void _processSignInResponseOk(http.Response response) {
    final decodedResponse = _parseHttpResponse(response);
    final user = User.fromJson(decodedResponse);
    _currentUserController.sink.add(user);
  }

  void _processRegisterResponseOK(http.Response response) {
    final decodedResponse = _parseHttpResponse(response);
    final user = User.fromJson(decodedResponse);
    _currentUserController.sink.add(user);
  }

  void _processStatusCode404NotFound(http.Response response) {
    final bodyMap = _parseHttpResponse(response);
    final parsedReason = bodyMap['title'];
    throw AuthResponseException(parsedReason ?? response.statusCode.toString());
  }

  Map<String, dynamic> _parseHttpResponse(http.Response response) {
    final decodedString = utf8.decode(response.bodyBytes);
    return jsonDecode(decodedString) as Map<String, dynamic>;
  }
}
