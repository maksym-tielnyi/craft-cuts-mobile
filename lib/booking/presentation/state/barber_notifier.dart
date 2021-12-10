import 'dart:async';

import 'package:craft_cuts_mobile/booking/domain/entities/barber.dart';
import 'package:craft_cuts_mobile/booking/domain/usecases/fetch_barbers_usecase.dart';
import 'package:craft_cuts_mobile/common/state/loading_state_notifier.dart';
import 'package:flutter/material.dart';

class BarberNotifier extends ChangeNotifier with LoadingStateNotifier {
  final FetchBarbersUsecase _fetchBarbersUsecase;

  StreamSubscription? _barbersSubscription;
  List<Barber>? _barbers;

  BarberNotifier(this._fetchBarbersUsecase);

  void subscribeToBarbers(
    Stream<List<Barber>?> stream,
  ) {
    _barbersSubscription?.cancel();
    _barbersSubscription = stream.listen(_barbersStreamListener);
  }

  void _barbersStreamListener(List<Barber>? value) {
    _barbers = value;
    setLoadingState(false);
  }

  List<Barber>? get barbers => _barbers;

  Future<void> fetchBarbers() async {
    if (isLoading) return;

    setLoadingState(true);
    try {
      await _fetchBarbersUsecase();
    } finally {
      setLoadingState(false);
    }
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
