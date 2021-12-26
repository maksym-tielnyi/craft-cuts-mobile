import 'package:copy_with_utils/copy_with_utils.dart';

class Service {
  final int id;
  final String name;
  final double price;
  final String? description;

  Service(this.id, this.name, this.price, this.description);

  Service copyWith({
    ValueCallback<int>? id,
    ValueCallback<String>? name,
    ValueCallback<double>? price,
    ValueCallback<String?>? description,
  }) {
    return Service(
      switcher(id, this.id),
      switcher(name, this.name),
      switcher(price, this.price),
      switcher(description, this.description),
    );
  }
}
