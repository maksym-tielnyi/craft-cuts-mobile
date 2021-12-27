import 'dart:async';

import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/appointment.dart';
import 'package:craft_cuts_mobile/booking/domain/usecases/fetch_customers_appointments.dart';
import 'package:craft_cuts_mobile/booking/domain/usecases/params/fetch_customers_appointments_param.dart';
import 'package:flutter/material.dart';

class AppointmentsNotifier extends ChangeNotifier {
  final FetchCustomersAppointments _fetchCustomersAppointments;

  StreamSubscription? _subscription;
  List<Appointment>? _appointments;
  User? _currentUser;
  bool _isLoading = false;

  AppointmentsNotifier(this._fetchCustomersAppointments);

  List<Appointment>? get appointments => _appointments;

  bool get isLoading => _isLoading;

  void handleCurrentUserUpdate(User? user) {
    _currentUser = user;
    _appointments = null;
    notifyListeners();
  }

  void subscribeToAppointmentsStream(Stream<List<Appointment>> stream) {
    if (_isLoading) {
      _isLoading = false;
      notifyListeners();
    }

    _subscription?.cancel();
    _subscription = stream.listen(
      (appointments) {
        _appointments = appointments;
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> fetchCustomerAppointments() async {
    if (isLoading || _currentUser == null) return;

    _isLoading = true;
    notifyListeners();
    return _fetchCustomersAppointments(
      FetchCustomersAppointmentsParam(_currentUser!),
    );
  }

  @override
  void dispose() {
    _cancelSubscriptions();
    super.dispose();
  }

  void _cancelSubscriptions() {
    _subscription?.cancel();
  }
}
