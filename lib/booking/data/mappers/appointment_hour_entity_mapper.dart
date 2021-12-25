import 'dart:convert';

import 'package:craft_cuts_mobile/booking/domain/entities/appointment_hour.dart';

class AppointmentHourEntityMapper {
  static AppointmentHour fromJson(Map<String, dynamic> json) =>
      AppointmentHour(DateTime.parse(json[_JsonFields.datetime]));

  static List<AppointmentHour>? fromJsonList(String jsonString) {
    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    final appointments = jsonList
        .map(
          (row) => AppointmentHour(DateTime.parse(row[_JsonFields.datetime])),
        )
        .toList();

    return appointments;
  }
}

class _JsonFields {
  static const datetime = 'allDates';
}
