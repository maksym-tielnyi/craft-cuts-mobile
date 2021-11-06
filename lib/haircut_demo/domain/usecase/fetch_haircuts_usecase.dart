import 'package:craft_cuts_mobile/common/domain/usecases/usecase.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/repositories/haircuts_repository.dart';

class FetchHaircutsUseCase implements UseCase<Future<void>, void> {
  final HaircutsRepository _haircutsRepository;

  FetchHaircutsUseCase(this._haircutsRepository);

  @override
  Future<void> call([_]) async {
    await _haircutsRepository.fetchHaircuts();
  }
}
