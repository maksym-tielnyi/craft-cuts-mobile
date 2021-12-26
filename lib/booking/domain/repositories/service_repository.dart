import 'package:craft_cuts_mobile/booking/domain/entities/service.dart';

abstract class ServiceRepository {
  Stream<List<Service>?> get servicesStream;

  Future<void> fetchServices();
}
