import 'package:craft_cuts_mobile/booking/domain/repositories/booking_repository.dart';
import 'package:craft_cuts_mobile/booking/domain/usecases/params/fetch_customers_appointments_param.dart';
import 'package:craft_cuts_mobile/common/domain/usecases/usecase.dart';

class FetchCustomersAppointments
    extends UseCase<Future<void>, FetchCustomersAppointmentsParam> {
  final BookingRepository _bookingRepository;

  FetchCustomersAppointments(this._bookingRepository);

  @override
  Future<void> call(FetchCustomersAppointmentsParam param) {
    return _bookingRepository.fetchAppointments(param.customer);
  }
}
