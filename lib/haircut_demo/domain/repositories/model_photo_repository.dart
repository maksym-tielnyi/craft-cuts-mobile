import 'package:image_picker/image_picker.dart';

abstract class ModelPhotoRepository {
  Stream<XFile?> get photoStream;

  void getPhotoWithCamera();

  void getPhotoFromGallery();
}
