import 'package:craft_cuts_mobile/haircut_demo/data/models/haircut_model.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ModelPhotoModel {
  final XFile? image;
  final Size? imageSize;
  final List<Face>? faces;
  final HaircutModel? selectedHaircut;

  ModelPhotoModel(
      {this.image, this.imageSize, this.faces, this.selectedHaircut});

  ModelPhotoModel copyWith({
    XFile? Function()? image,
    Size? Function()? imageSize,
    List<Face>? Function()? faces,
    HaircutModel? Function()? selectedHaircut,
  }) =>
      ModelPhotoModel(
        image: image != null ? image() : this.image,
        imageSize: imageSize != null ? imageSize() : this.imageSize,
        faces: faces != null ? faces() : this.faces,
        selectedHaircut:
            selectedHaircut != null ? selectedHaircut() : this.selectedHaircut,
      );
}
