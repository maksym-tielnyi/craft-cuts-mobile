import 'package:craft_cuts_mobile/booking/domain/entities/service.dart';

class ServiceEntityMapper {
  static Service fromJson(Map<String, dynamic> map) {
    return Service(
      map[_JsonFields.serviceId] as int,
      map[_JsonFields.name] as String,
      (map[_JsonFields.price] as int).toDouble(),
      map[_JsonFields.description] as String?,
    );
  }

  static Map<String, dynamic> toJson(Service service) {
    throw UnimplementedError();
  }
}

class _JsonFields {
  static const serviceId = 'service_id';
  static const name = 'name';
  static const price = 'price';
  static const description = 'description';
}
