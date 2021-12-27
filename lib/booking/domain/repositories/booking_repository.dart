import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/appointment.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/booking.dart';

abstract class BookingRepository {
  Stream<List<Appointment>?> get appointmentsStream;

  Future<bool> addBooking(Booking booking, User user);

  Future<void> fetchAppointments(User user);
}
