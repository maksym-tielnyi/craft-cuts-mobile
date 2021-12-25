import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class HttpResponseHandler<Result> {
  HttpResponseHandler(
    this.response, {
    required this.onOK,
  }) {
    _processResponse();
  }

  final Response response;
  final Result Function(Response response) onOK;
  bool? _isError;
  String? _errorDescription;
  Result? _result;

  void _processResponse() {
    if (response.statusCode == HttpStatus.ok) {
      _processResponseOK();
    } else {
      _processResponseFailed();
    }
  }

  void _processResponseOK() {
    _isError = false;
    _result = onOK(response);
  }

  void _processResponseFailed() {
    _isError = true;
    _errorDescription = utf8.decode(response.bodyBytes);
  }

  bool? get isError => _isError;

  String? get errorDescription => _errorDescription;

  Result? get result => _result;
}
