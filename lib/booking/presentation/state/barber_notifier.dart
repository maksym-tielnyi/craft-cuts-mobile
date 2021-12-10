import 'dart:async';

import 'package:craft_cuts_mobile/booking/domain/entities/barber.dart';
import 'package:craft_cuts_mobile/booking/domain/usecases/fetch_barbers_usecase.dart';
import 'package:flutter/material.dart';

class BarberNotifier extends ChangeNotifier {
  final FetchBarbersUsecase _fetchBarbersUsecase;

  StreamSubscription? _barbersSubscription;
  List<Barber>? _barbers;
  bool _isLoading = false;

  BarberNotifier(this._fetchBarbersUsecase);

  void subscribeToBarbers(
    Stream<List<Barber>?> stream,
  ) {
    _barbersSubscription?.cancel();
    _barbersSubscription = stream.listen(_barbersStreamListener);
  }

  void _barbersStreamListener(List<Barber>? value) {
    _barbers = value;
    _setLoadingState(false);
  }

  List<Barber>? get barbers => _barbers;

  bool get isLoading => _isLoading;

  Future<void> fetchBarbers() async {
    if (_isLoading) return;

    _setLoadingState(true);
    try {
      await _fetchBarbersUsecase();
    } finally {
      _setLoadingState(false);
    }
  }

  void _setLoadingState(bool value) {
    if (_isLoading == value) return;

    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _cancelSubscriptions();
    super.dispose();
  }

  void _cancelSubscriptions() {
    _barbersSubscription?.cancel();
  }
}
