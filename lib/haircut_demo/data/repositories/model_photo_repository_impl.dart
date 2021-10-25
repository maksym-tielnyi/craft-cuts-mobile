import 'dart:async';

import 'package:craft_cuts_mobile/haircut_demo/domain/repositories/model_photo_repository.dart';
import 'package:image_picker/image_picker.dart';

class ModelPhotoRepositoryImpl implements ModelPhotoRepository {
  final _imagePicker = ImagePicker();
  final _photoStreamController = StreamController<XFile?>();

  @override
  Future<void> getPhotoFromGallery() async {
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      _photoStreamController.sink.add(pickedImage);
    }
  }

  @override
  Future<void> getPhotoWithCamera() async {
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedImage != null) {
      _photoStreamController.sink.add(pickedImage);
    }
  }

  @override
  Stream<XFile?> get photoStream => _photoStreamController.stream;
}
