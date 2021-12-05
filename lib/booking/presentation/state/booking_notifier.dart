import 'dart:math';

import 'package:craft_cuts_mobile/booking/presentation/viewmodels/booking_error_viewmodel.dart';
import 'package:flutter/material.dart';

class BookingNotifier extends ChangeNotifier {
  bool _isLoading = false;
  bool? _lastBookingSuccessful;
  BookingErrorViewModel? _lastError;

  bool get isLoading => _isLoading;

  bool? get lastBookingSuccessful => _lastBookingSuccessful;

  BookingErrorViewModel? get lastError => _lastError;

  Future<void> confirmBooking() async {
    // TODO: implement confirmBooking()
    _clearBookingResultsState();
    if (Random().nextBool()) {
      _lastBookingSuccessful = true;
    } else {
      _lastBookingSuccessful = false;
      _lastError = BookingErrorViewModel(errorType: BookingErrorType.unknown);
    }
    notifyListeners();
  }

  void _clearBookingResultsState() {
    _lastError = _lastBookingSuccessful = null;
  }
}
