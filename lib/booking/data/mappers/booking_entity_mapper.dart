import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/booking.dart';

class BookingEntityMapper {
  Map<String, dynamic> toJson(
    Booking booking, {
    User? user,
  }) {
    return <String, dynamic>{
      _quoted(_JsonFields.barberName)!: _quoted(booking.master!.name),
      _quoted(_JsonFields.customerEmail)!: _quoted(user!.email),
      _quoted(_JsonFields.serviceName)!: _quoted(booking.service!.name),
      _quoted(_JsonFields.date)!: _quoted(
        booking.time!.toUtc().toIso8601String(),
      ),
      _quoted(_JsonFields.promocodeName)!: _quoted(null),
    };
  }

  String? _quoted(String? str) => str != null ? '"$str"' : null;
}

class _JsonFields {
  static const barberName = 'BarberName';
  static const customerEmail = 'CustomerEmail';
  static const serviceName = 'ServiceName';
  static const date = 'Date';
  static const promocodeName = 'PromocodeName';
}
