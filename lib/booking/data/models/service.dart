class Service {
  final String? id;
  final String? name;
  final double? price;
  final String? description;

  Service(this.id, this.name, this.price, this.description);

  factory Service.fromJson(Map<String, dynamic> map) {
    return Service(
      map['service_id'] as String?,
      map['name'] as String?,
      map['price'] as double?,
      map['description'] as String?,
    );
  }
}
