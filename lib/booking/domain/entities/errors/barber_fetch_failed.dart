import 'package:craft_cuts_mobile/booking/domain/entities/errors/barber_exception.dart';

class BarberFetchFailed extends BarberException {
  BarberFetchFailed({String? description}) : super(description: description);
}
