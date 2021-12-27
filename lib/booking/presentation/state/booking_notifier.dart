import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/barber.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/booking.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/service.dart';
import 'package:craft_cuts_mobile/booking/domain/usecases/add_booking_usecase.dart';
import 'package:craft_cuts_mobile/booking/domain/usecases/params/add_booking_param.dart';
import 'package:craft_cuts_mobile/booking/presentation/viewmodels/booking_error_view_model.dart';
import 'package:flutter/material.dart';

class BookingNotifier extends ChangeNotifier {
  final AddBookingUseCase _addBookingUseCase;

  bool _isLoading = false;
  bool? _lastBookingSuccessful;
  BookingErrorViewModel? _lastError;
  Booking? _booking;
  User? _currentUser;

  BookingNotifier(this._addBookingUseCase);

  bool get isLoading => _isLoading;

  bool? get lastBookingSuccessful => _lastBookingSuccessful;

  Booking? get booking => _booking;

  BookingErrorViewModel? get lastError => _lastError;

  void handleCurrentUserUpdate(User? user) {
    _currentUser = user;
  }

  Future<void> confirmBooking() async {
    final bookingData = _booking;
    final currentUserId = _currentUser;
    if (bookingData == null || currentUserId == null) return;
    _clearBookingResultsState();

    try {
      final bookingResult =
          await _addBookingUseCase(AddBookingParam(currentUserId, bookingData));
      if (bookingResult) {
        _lastBookingSuccessful = true;
      } else {
        _lastBookingSuccessful = false;
        _lastError = BookingErrorViewModel();
      }
    } catch (e) {
      _lastBookingSuccessful = false;
      _lastError = BookingErrorViewModel();
    } finally {
      notifyListeners();
    }
  }

  set master(Barber? barber) {
    if (_isLoading) return;

    final booking = _booking;
    _booking = booking == null
        ? Booking(master: barber)
        : booking.copyWith(master: () => barber);

    _clearBookingResultsState();
    notifyListeners();
  }

  set date(DateTime? date) {
    if (_isLoading) return;

    final booking = _booking;
    _booking = booking == null
        ? Booking(date: date)
        : booking.copyWith(date: () => date);

    _clearBookingResultsState();
    notifyListeners();
  }

  set time(DateTime? time) {
    if (_isLoading) return;

    final booking = _booking;
    _booking = booking == null
        ? Booking(time: time)
        : booking.copyWith(time: () => time);

    _clearBookingResultsState();
    notifyListeners();
  }

  set service(Service? service) {
    if (_isLoading) return;

    final booking = _booking;
    _booking = booking == null
        ? Booking(service: service)
        : booking.copyWith(service: () => service);

    _clearBookingResultsState();
    notifyListeners();
  }

  void _clearBookingResultsState() {
    _lastError = _lastBookingSuccessful = null;
  }
}
