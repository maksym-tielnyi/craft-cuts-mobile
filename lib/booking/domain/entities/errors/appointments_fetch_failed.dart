import 'package:craft_cuts_mobile/booking/domain/entities/errors/appointments_fetch_exception.dart';

class AppointmentsFetchFailed extends AppointmentsFetchException {
  AppointmentsFetchFailed({String? description})
      : super(description: description);
}
