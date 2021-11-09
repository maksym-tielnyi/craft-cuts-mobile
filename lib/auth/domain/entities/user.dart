class User {
  final int? userId;
  final String email;
  final String name;
  final String password;
  final String phone;
  final DateTime birthday;

  User(this.userId, this.email, this.name, this.password, this.phone,
      this.birthday);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json[_JsonFields.id],
      json[_JsonFields.email],
      json[_JsonFields.name],
      json[_JsonFields.password],
      json[_JsonFields.phone],
      json[_JsonFields.birthday],
    );
  }

  Map<String, String> toMap() {
    return {
      _JsonFields.name: name,
      _JsonFields.email: email,
      _JsonFields.phone: phone,
      _JsonFields.password: password,
      _JsonFields.birthday: _datetimeToAPICompatibleFormatString(
        birthday.toUtc(),
      ),
    };
  }

  String _datetimeToAPICompatibleFormatString(DateTime date) {
    final dateTimeStr = date.toIso8601String();
    print(dateTimeStr);
    return dateTimeStr;
  }
}

class _JsonFields {
  static const id = 'customer_id';
  static const name = 'name';
  static const email = 'email';
  static const phone = 'phone';
  static const password = 'password';
  static const birthday = 'birthday';
}
