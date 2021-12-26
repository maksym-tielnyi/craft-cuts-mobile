import 'dart:async';

import 'package:craft_cuts_mobile/booking/domain/entities/service.dart';
import 'package:craft_cuts_mobile/booking/domain/usecases/fetch_services_usecase.dart';
import 'package:craft_cuts_mobile/common/state/loading_state_notifier.dart';
import 'package:flutter/cupertino.dart';

class ServiceNotifier extends ChangeNotifier with LoadingStateNotifier {
  final FetchServicesUsecase _fetchServicesUsecase;

  StreamSubscription? _servicesSubscription;
  List<Service>? _services;

  ServiceNotifier(this._fetchServicesUsecase);

  void subscribeToServices(Stream<List<Service>?> stream) {
    _servicesSubscription?.cancel();
    _servicesSubscription = stream.listen(_servicesListener);
  }

  void _servicesListener(List<Service>? services) {
    _services = services;
    setLoadingState(false);
  }

  List<Service>? get services => _services;

  Future<void> fetchServices() async {
    if (isLoading) return;

    setLoadingState(true);
    try {
      await _fetchServicesUsecase();
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
    _servicesSubscription?.cancel();
  }
}
