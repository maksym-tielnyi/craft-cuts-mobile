class StoredUserCredentials {
  final String? login;
  final String? password;

  const StoredUserCredentials(this.login, this.password);

  bool get isValid => login != null && password != null;
}
