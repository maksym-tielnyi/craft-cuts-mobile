import 'package:craft_cuts_mobile/booking/domain/entities/barber.dart';

abstract class BarberRepository {
  Stream<List<Barber>?> get barbersStream;

  Future<void> fetchBarbers();
}
