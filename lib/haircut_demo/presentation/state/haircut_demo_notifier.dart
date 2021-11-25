import 'dart:async';

import 'package:craft_cuts_mobile/haircut_demo/data/models/haircut_model.dart';
import 'package:craft_cuts_mobile/haircut_demo/data/models/model_photo_model.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/usecase/fetch_haircuts_usecase.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/usecase/get_photo_from_camera_usecase.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/usecase/get_photo_from_gallery_usecase.dart';
import 'package:craft_cuts_mobile/haircut_demo/presentation/viewmodels/haircuts_viewmodel.dart';
import 'package:craft_cuts_mobile/haircut_demo/util/image_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HaircutDemoNotifier extends ChangeNotifier {
  final GetPhotoFromCameraUseCase _getPhotoFromCameraUseCase;
  final GetPhotoFromGalleryUseCase _getPhotoFromGalleryUseCase;
  final FetchHaircutsUseCase _fetchHaircutsUseCase;

  StreamSubscription? _modelPhotoSubscription;
  StreamSubscription? _haircutsSubscription;

  bool _loading = false;
  var _modelPhotoModel = ModelPhotoModel();
  var _haircutsViewModel = HaircutsViewModel(null);

  bool get isLoading => _loading;

  ModelPhotoModel get modelPhotoViewModel => _modelPhotoModel;

  HaircutsViewModel get haircutsViewModel => _haircutsViewModel;

  HaircutDemoNotifier(
    this._getPhotoFromCameraUseCase,
    this._getPhotoFromGalleryUseCase,
    this._fetchHaircutsUseCase,
  );

  Future<void> getModelPhotoFromGallery() async {
    _loading = true;
    notifyListeners();
    await _getPhotoFromGalleryUseCase();
  }

  Future<void> getModelPhotoFromCamera() async {
    await _getPhotoFromCameraUseCase();
  }

  Future<void> fetchHaircuts() async {
    await _fetchHaircutsUseCase();
  }

  void subscribeToModelPhoto(Stream<XFile?> stream) {
    _modelPhotoSubscription = stream.listen(_modelPhotoListener);
  }

  void subscribeToHaircuts(Stream<List<HaircutModel>?> stream) {
    _haircutsSubscription = stream.listen(_haircutsListener);
  }

  Future<void> handleSelectedHaircutChanged(
      HaircutModel? selectedHaircut) async {
    _modelPhotoModel =
        _modelPhotoModel.copyWith(selectedHaircut: () => selectedHaircut);
    notifyListeners();
  }

  Future<void> _modelPhotoListener(XFile? photo) async {
    Size? imageSize;
    if (photo != null) {
      final image = await ImageUtils.imageFromXFile(photo);
      imageSize = Size(image.width.toDouble(), image.height.toDouble());
    }

    _modelPhotoModel = _modelPhotoModel.copyWith(
      image: () => photo,
      imageSize: () => imageSize,
      faces: () => null,
    );

    _loading = true;
    notifyListeners();

    try {
      if (photo != null) {
        await _findFaces();
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> _findFaces() async {
    final faces = await ImageUtils.findFaceCoordinates(_modelPhotoModel.image!);
    _modelPhotoModel = _modelPhotoModel.copyWith(faces: () => faces);
  }

  void _haircutsListener(List<HaircutModel>? haircuts) async {
    _haircutsViewModel = HaircutsViewModel(haircuts);
    notifyListeners();
  }

  @override
  void dispose() {
    _modelPhotoSubscription!.cancel();
    _haircutsSubscription!.cancel();
    super.dispose();
  }
}
