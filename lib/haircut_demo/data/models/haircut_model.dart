class HaircutModel {
  final int? id;
  final String imageName;
  final String displayedName;

  HaircutModel(this.id, this.imageName, this.displayedName);

  factory HaircutModel.fromJson(Map<String, dynamic> json) => HaircutModel(
        json[_JsonFields.id],
        json[_JsonFields.imageName],
        json[_JsonFields.displayedName],
      );

  Map<String, String> toMap() {
    return {
      _JsonFields.id: id.toString(),
      _JsonFields.imageName: imageName,
      _JsonFields.displayedName: displayedName,
    };
  }
}

class _JsonFields {
  static const id = 'haircut_id';
  static const imageName = 'image_name';
  static const displayedName = 'displayed_name';
}
