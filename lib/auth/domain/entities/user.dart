class User {
  final int? userId;
  final String email;
  final String name;
  final String password;
  final String phone;

  User(this.userId, this.email, this.name, this.password, this.phone);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json[_JsonFields.id],
      json[_JsonFields.email],
      json[_JsonFields.name],
      '',
      json[_JsonFields.phone],
    );
  }

  Map<String, String> toMap() {
    print(DateTime.now().toString());
    return {
      _JsonFields.name: name,
      _JsonFields.email: email,
      _JsonFields.phone: phone,
      _JsonFields.birthday: DateTime.now().toString(),
    };
  }
}

class _JsonFields {
  static const id = 'customer_id';
  static const name = 'name';
  static const email = 'email';
  static const phone = 'phone';
  static const birthday = 'birthday';
}
