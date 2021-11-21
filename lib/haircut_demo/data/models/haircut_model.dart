import 'dart:convert';

class HaircutModel {
  final int? id;
  final String imageName;
  final String? displayedName;

  HaircutModel(this.id, this.imageName, this.displayedName);

  factory HaircutModel.fromJson(Map<String, dynamic> json) => HaircutModel(
        json[_JsonFields.id],
        json[_JsonFields.imageName],
        json[_JsonFields.displayedName] as String?,
      );

  static List<HaircutModel> fromJsonList(String json) {
    final jsonList = jsonDecode(json) as List<dynamic>;
    final haircuts = jsonList
        .map(
          (row) => HaircutModel(
            row[_JsonFields.id] as int?,
            row[_JsonFields.imageName],
            row[_JsonFields.displayedName] as String?,
          ),
        )
        .toList();
    return haircuts;
  }
}

class _JsonFields {
  static const id = 'haircut_id';
  static const imageName = 'image_name';
  static const displayedName = 'displayed_name';
}
