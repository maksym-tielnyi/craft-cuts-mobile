class AuthResponseException implements Exception {
  final String message;

  AuthResponseException(this.message);

  String toString() {
    return message;
  }
}
