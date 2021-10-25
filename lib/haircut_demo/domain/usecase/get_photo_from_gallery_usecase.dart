import 'package:craft_cuts_mobile/common/domain/usecases/usecase.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/repositories/model_photo_repository.dart';

class GetPhotoFromGalleryUseCase implements UseCase<Future<void>, void> {
  final ModelPhotoRepository _modelPhotoRepository;

  GetPhotoFromGalleryUseCase(this._modelPhotoRepository);

  @override
  Future<void> call([_]) async {
    return _modelPhotoRepository.getPhotoFromGallery();
  }
}
