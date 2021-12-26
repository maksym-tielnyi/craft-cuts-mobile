import 'package:craft_cuts_mobile/booking/domain/entities/errors/booking_exception.dart';

class BookingErrorViewModel {
  final String? description;
  final BookingException? exception;

  BookingErrorViewModel({this.description, this.exception});
}
