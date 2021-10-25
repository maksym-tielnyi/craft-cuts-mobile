import 'dart:async';

import 'package:craft_cuts_mobile/haircut_demo/domain/usecase/get_photo_from_camera_usecase.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/usecase/get_photo_from_gallery_usecase.dart';
import 'package:craft_cuts_mobile/haircut_demo/presentation/viewmodels/model_photo_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class HaircutDemoNotifier extends ChangeNotifier {
  final GetPhotoFromCameraUseCase _getPhotoFromCameraUseCase;
  final GetPhotoFromGalleryUseCase _getPhotoFromGalleryUseCase;

  StreamSubscription? _modelPhotoSubscription;

  var _modelPhotoViewModel = ModelPhotoViewModel(null);

  ModelPhotoViewModel get modelPhotoViewModel => _modelPhotoViewModel;

  HaircutDemoNotifier(
    this._getPhotoFromCameraUseCase,
    this._getPhotoFromGalleryUseCase,
  );

  Future<void> getModelPhotoFromGallery() async {
    await _getPhotoFromGalleryUseCase();
  }

  Future<void> getModelPhotoFromCamera() async {
    await _getPhotoFromCameraUseCase();
  }

  void subscribeToModelPhoto(Stream<XFile?> stream) {
    _modelPhotoSubscription = stream.listen(_modelPhotoListener);
  }

  void _modelPhotoListener(XFile? photo) async {
    if (photo == null) {
      _modelPhotoViewModel = ModelPhotoViewModel(null);
    } else {
      final photoBytes = await photo.readAsBytes();
      _modelPhotoViewModel = ModelPhotoViewModel(photoBytes);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _modelPhotoSubscription!.cancel();
    super.dispose();
  }
}
