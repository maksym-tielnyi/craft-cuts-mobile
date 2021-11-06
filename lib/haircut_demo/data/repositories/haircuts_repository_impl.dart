import 'dart:async';

import 'package:craft_cuts_mobile/haircut_demo/data/models/haircut_model.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/repositories/haircuts_repository.dart';

class HaircutsRepositoryImpl implements HaircutsRepository {
  final _haircutStreamController = StreamController<List<HaircutModel>?>();

  @override
  Future<void> fetchHaircuts() async {
    await Future.delayed(Duration(seconds: 5));
    _haircutStreamController.sink.add([
      HaircutModel(null, 'haircut1', 'my haircut'),
      HaircutModel(null, 'haircut1', 'my haircut'),
    ]);
  }

  @override
  Stream<List<HaircutModel>?> get haircutStream =>
      _haircutStreamController.stream;
}
