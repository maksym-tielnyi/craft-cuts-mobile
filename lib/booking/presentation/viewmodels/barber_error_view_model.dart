import 'package:craft_cuts_mobile/booking/domain/entities/errors/barber_exception.dart';

class BarberErrorViewModel {
  final String? description;
  final BarberException? exception;

  BarberErrorViewModel({this.description, this.exception});
}
