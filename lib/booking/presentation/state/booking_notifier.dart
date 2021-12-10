import 'dart:math';

import 'package:craft_cuts_mobile/booking/domain/entities/booking.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/service.dart';
import 'package:craft_cuts_mobile/booking/presentation/viewmodels/booking_error_view_model.dart';
import 'package:flutter/material.dart';

class BookingNotifier extends ChangeNotifier {
  bool _isLoading = false;
  bool? _lastBookingSuccessful;
  BookingErrorViewModel? _lastError;
  Booking? _booking;

  bool get isLoading => _isLoading;

  bool? get lastBookingSuccessful => _lastBookingSuccessful;

  Booking? get booking => _booking;

  BookingErrorViewModel? get lastError => _lastError;

  Future<void> confirmBooking() async {
    _clearBookingResultsState();
    if (Random().nextBool()) {
      _lastBookingSuccessful = true;
    } else {
      _lastBookingSuccessful = false;
      _lastError = BookingErrorViewModel();
    }
    notifyListeners();
  }

  set masterEmail(String? email) {
    if (_isLoading) return;

    final booking = _booking;
    _booking = booking == null
        ? Booking(masterEmail: email)
        : booking.copyWith(masterEmail: () => email);

    notifyListeners();
  }

  set date(DateTime? date) {
    if (_isLoading) return;

    final booking = _booking;
    _booking = booking == null
        ? Booking(date: date)
        : booking.copyWith(date: () => date);

    notifyListeners();
  }

  set time(DateTime? time) {
    if (_isLoading) return;

    final booking = _booking;
    _booking = booking == null
        ? Booking(time: time)
        : booking.copyWith(time: () => time);

    notifyListeners();
  }

  set service(Service? service) {
    if (_isLoading) return;

    final booking = _booking;
    _booking = booking == null
        ? Booking(service: service)
        : booking.copyWith(service: () => service);

    notifyListeners();
  }

  void _clearBookingResultsState() {
    _lastError = _lastBookingSuccessful = null;
  }
}
