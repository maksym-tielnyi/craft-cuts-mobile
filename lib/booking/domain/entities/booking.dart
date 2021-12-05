import 'package:craft_cuts_mobile/booking/data/models/service.dart';

class Booking {
  final String? masterEmail;
  final DateTime? date;
  final DateTime? time;
  final Service? service;

  Booking(this.masterEmail, this.date, this.time, this.service);
}
