import 'package:craft_cuts_mobile/booking/domain/entities/errors/service_exception.dart';

class ServiceFetchFailed extends ServiceException {
  ServiceFetchFailed({String? description}) : super(description: description);
}
