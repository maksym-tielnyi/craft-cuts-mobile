import 'package:craft_cuts_mobile/booking/domain/repositories/barber_repository.dart';
import 'package:craft_cuts_mobile/common/domain/usecases/usecase.dart';

class FetchBarbersUsecase extends UseCase<Future<void>, void> {
  final BarberRepository _repository;

  const FetchBarbersUsecase(this._repository);

  @override
  Future<void> call([_]) async {
    await _repository.fetchBarbers();
  }
}
