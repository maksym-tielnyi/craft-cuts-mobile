import 'dart:async';
import 'dart:io';

import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/auth/domain/repositories/exceptions/auth_response_exception.dart';
import 'package:craft_cuts_mobile/auth/domain/repositories/user_repository.dart';
import 'package:craft_cuts_mobile/common/config/api_config.dart';
import 'package:craft_cuts_mobile/common/utils/http_response_utils.dart';
import 'package:http/http.dart' as http;

class UserRepositoryImpl implements UserRepository {
  static const _unencodedRegisterPath = 'api/Customer/Registration';
  static const _unencodedSignInPath = 'api/Customer/AuthMobile';

  final _client = http.Client();
  final _currentUserController = StreamController<User?>();

  Stream<User?> get currentUser => _currentUserController.stream;

  @override
  void registerUser(User userData) async {
    final requestBody = userData.toMap();
    final requestUri = Uri.https(Api.baseUrl, _unencodedRegisterPath);

    final response = await _client.post(requestUri, body: requestBody);
    _processRegisterResponse(response);
  }

  @override
  void signInWithEmailAndPassword(String email, String password) async {
    final params = {
      'email': email,
      'password': password,
    };

    final requestUri = Uri.https(Api.baseUrl, _unencodedSignInPath, params);

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
    } else {
      _processStatusCodeFailed(response);
    }
  }

  void _processRegisterResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      _processRegisterResponseOK(response);
    } else {
      _processStatusCodeFailed(response);
    }
  }

  void _processSignInResponseOk(http.Response response) {
    final decodedResponse = HttpResponseUtils.parseHttpResponse(response);
    final user = User.fromJson(decodedResponse);
    _currentUserController.sink.add(user);
  }

  void _processRegisterResponseOK(http.Response response) {
    final decodedResponse = HttpResponseUtils.parseHttpResponse(response);
    final user = User.fromJson(decodedResponse);
    _currentUserController.sink.add(user);
  }

  void _processStatusCodeFailed(http.Response response) {
    final bodyMap = HttpResponseUtils.parseHttpResponse(response);
    final parsedReason = bodyMap['message'];
    throw AuthResponseException(parsedReason ?? response.statusCode.toString());
  }
}
