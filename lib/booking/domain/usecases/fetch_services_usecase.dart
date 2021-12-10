import 'package:craft_cuts_mobile/booking/domain/repositories/service_repository.dart';
import 'package:craft_cuts_mobile/common/domain/usecases/usecase.dart';

class FetchServicesUsecase extends UseCase<Future<void>, void> {
  final ServiceRepository _repository;

  const FetchServicesUsecase(this._repository);

  @override
  Future<void> call([_]) async {
    await _repository.fetchServices();
  }
}
