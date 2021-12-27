import 'dart:convert';

import 'package:craft_cuts_mobile/booking/domain/entities/appointment.dart';

class AppointmentEntityMapper {
  Appointment fromJson(Map<String, dynamic> json) => Appointment(
      id: json[_JsonFields.appointment_id] as int?,
      barberId: json[_JsonFields.barber_id] as int?,
      customerId: json[_JsonFields.customer_id] as int?,
      price: double.tryParse(json[_JsonFields.price].toString()),
      date: DateTime.tryParse(json[_JsonFields.date]),
      isPaid: json[_JsonFields.isPaid] as bool?,
      promocodeId: json[_JsonFields.promocodeId]);

  List<Appointment> fromJsonList(String jsonString) {
    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    return jsonList.map((row) => fromJson(row)).toList();
  }
}

class _JsonFields {
  static const appointment_id = 'booking_id';
  static const barber_id = 'barber_id';
  static const customer_id = 'customer_id';
  static const price = 'price';
  static const date = 'date';
  static const isPaid = 'is_paid';
  static const promocodeId = 'promocode_id';
}
