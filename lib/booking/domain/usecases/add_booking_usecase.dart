import 'package:craft_cuts_mobile/booking/domain/repositories/booking_repository.dart';
import 'package:craft_cuts_mobile/booking/domain/usecases/params/add_booking_param.dart';
import 'package:craft_cuts_mobile/common/domain/usecases/usecase.dart';

class AddBookingUseCase extends UseCase<Future<bool>, AddBookingParam> {
  BookingRepository _bookingRepository;

  AddBookingUseCase(this._bookingRepository);

  @override
  Future<bool> call(AddBookingParam params) {
    return _bookingRepository.addBooking(params.bookingData, params.customer);
  }
}
