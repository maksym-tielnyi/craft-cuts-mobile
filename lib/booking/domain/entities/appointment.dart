class Appointment {
  final int? id;
  final int? barberId;
  final int? customerId;
  final double? price;
  final DateTime? date;
  final bool? isPaid;
  final String? promocodeId;

  Appointment({
    this.id,
    this.barberId,
    this.customerId,
    this.price,
    this.date,
    this.isPaid,
    this.promocodeId,
  });
}
