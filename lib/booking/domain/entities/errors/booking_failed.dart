import 'package:craft_cuts_mobile/booking/domain/entities/errors/booking_exception.dart';

class BookingFailed implements BookingException {
  final String? description;

  BookingFailed({
    this.description,
  });
}
