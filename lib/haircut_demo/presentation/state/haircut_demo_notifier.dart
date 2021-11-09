import 'dart:async';

import 'package:craft_cuts_mobile/haircut_demo/data/models/haircut_model.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/usecase/fetch_haircuts_usecase.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/usecase/get_photo_from_camera_usecase.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/usecase/get_photo_from_gallery_usecase.dart';
import 'package:craft_cuts_mobile/haircut_demo/presentation/viewmodels/haircuts_viewmodel.dart';
import 'package:craft_cuts_mobile/haircut_demo/presentation/viewmodels/model_photo_viewmodel.dart';
import 'package:craft_cuts_mobile/haircut_demo/util/image_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HaircutDemoNotifier extends ChangeNotifier {
  final GetPhotoFromCameraUseCase _getPhotoFromCameraUseCase;
  final GetPhotoFromGalleryUseCase _getPhotoFromGalleryUseCase;
  final FetchHaircutsUseCase _fetchHaircutsUseCase;

  StreamSubscription? _modelPhotoSubscription;
  StreamSubscription? _haircutsSubscription;

  var _modelPhotoViewModel = ModelPhotoViewModel();
  var _haircutsViewModel = HaircutsViewModel(null);

  ModelPhotoViewModel get modelPhotoViewModel => _modelPhotoViewModel;

  HaircutsViewModel get haircutsViewModel => _haircutsViewModel;

  HaircutDemoNotifier(
    this._getPhotoFromCameraUseCase,
    this._getPhotoFromGalleryUseCase,
    this._fetchHaircutsUseCase,
  );

  Future<void> getModelPhotoFromGallery() async {
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

  void _modelPhotoListener(XFile? photo) async {
    if (photo == null) {
      _modelPhotoViewModel = ModelPhotoViewModel();
    } else {
      _modelPhotoViewModel = ModelPhotoViewModel(photoBytes: photo);
      final faceCoordinates = await ImageUtils.findFaceCoordinates(photo);
      print(faceCoordinates.length);
    }
    notifyListeners();
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
