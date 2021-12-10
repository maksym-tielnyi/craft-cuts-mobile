import 'package:copy_with_utils/copy_with_utils.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/service.dart';
import 'package:flutter/material.dart';

class Booking {
  final String? masterEmail;
  final DateTime? date;
  final DateTime? time;
  final Service? service;

  Booking({this.masterEmail, this.date, this.time, this.service});

  Booking copyWith({
    ValueCallback<String?>? masterEmail,
    ValueCallback<DateTime?>? date,
    ValueCallback<DateTime?>? time,
    ValueCallback<Service?>? service,
  }) {
    final dateVal = switcher(date, this.date);

    return Booking(
      masterEmail: switcher(masterEmail, this.masterEmail),
      date: dateVal == null ? dateVal : DateUtils.dateOnly(dateVal),
      time: switcher(time, this.time),
      service: switcher(service, this.service),
    );
  }
}
