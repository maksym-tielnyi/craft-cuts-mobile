import 'package:copy_with_utils/copy_with_utils.dart';

class Barber {
  final int barberId;
  final String email;
  final String name;
  final String photoName;

  Barber(this.barberId, this.email, this.name, this.photoName);

  Barber copyWith({
    ValueCallback<int>? barberId,
    ValueCallback<String>? email,
    ValueCallback<String>? name,
    ValueCallback<String>? photoName,
  }) =>
      Barber(
        switcher(barberId, this.barberId),
        switcher(email, this.email),
        switcher(name, this.name),
        switcher(photoName, this.photoName),
      );
}
