import 'package:craft_cuts_mobile/booking/domain/entities/barber.dart';

class BarberEntityMapper {
  static Barber fromJson(Map<String, dynamic> json) => Barber(
        json[_JsonFields.id],
        json[_JsonFields.email],
        json[_JsonFields.name],
        json[_JsonFields.photoName],
      );

  static Map<String, dynamic> toJson(Barber barber) {
    throw UnimplementedError();
  }
}

class _JsonFields {
  static const id = 'barber_id';
  static const email = 'email';
  static const name = 'name';
  static const password = 'password';
  static const photoName = 'photo_name';
}
