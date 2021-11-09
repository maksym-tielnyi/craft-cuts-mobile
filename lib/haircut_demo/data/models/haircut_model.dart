import 'dart:typed_data';

class HaircutModel {
  final int? id;
  final Uint8List imageBytes;
  final String displayedName;

  HaircutModel(this.id, this.imageBytes, this.displayedName);

  factory HaircutModel.fromJson(Map<String, dynamic> json) => HaircutModel(
        json[_JsonFields.id],
        json[_JsonFields.imageName],
        json[_JsonFields.displayedName],
      );
}

class _JsonFields {
  static const id = 'haircut_id';
  static const imageName = 'image_name';
  static const displayedName = 'displayed_name';
}
