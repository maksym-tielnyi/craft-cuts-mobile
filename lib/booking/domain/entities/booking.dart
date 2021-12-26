import 'package:copy_with_utils/copy_with_utils.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/barber.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/service.dart';
import 'package:flutter/material.dart';

class Booking {
  final Barber? master;
  final DateTime? date;
  final DateTime? time;
  final Service? service;

  Booking({this.master, this.date, this.time, this.service});

  Booking copyWith({
    ValueCallback<Barber?>? master,
    ValueCallback<DateTime?>? date,
    ValueCallback<DateTime?>? time,
    ValueCallback<Service?>? service,
  }) {
    final dateVal = switcher(date, this.date);

    return Booking(
      master: switcher(master, this.master),
      date: dateVal == null ? dateVal : DateUtils.dateOnly(dateVal),
      time: switcher(time, this.time),
      service: switcher(service, this.service),
    );
  }
}
