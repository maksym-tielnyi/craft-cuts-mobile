import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/booking.dart';

class AddBookingParam {
  final User customer;
  final Booking bookingData;

  AddBookingParam(this.customer, this.bookingData);
}
