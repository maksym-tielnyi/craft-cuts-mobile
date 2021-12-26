import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/booking.dart';

abstract class BookingRepository {
  Future<bool> addBooking(Booking booking, User user);
}
