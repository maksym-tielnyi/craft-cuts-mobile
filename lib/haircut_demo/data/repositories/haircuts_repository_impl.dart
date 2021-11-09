import 'dart:async';
import 'dart:typed_data';

import 'package:craft_cuts_mobile/haircut_demo/data/models/haircut_model.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/repositories/haircuts_repository.dart';
import 'package:flutter/services.dart';

class HaircutsRepositoryImpl implements HaircutsRepository {
  final _haircutStreamController = StreamController<List<HaircutModel>?>();

  @override
  Future<void> fetchHaircuts() async {
    await Future.delayed(Duration(seconds: 5));
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(
                'https://upload.wikimedia.org/wikipedia/commons/a/a0/Pierre-Person.jpg'))
            .load(
                'https://upload.wikimedia.org/wikipedia/commons/a/a0/Pierre-Person.jpg'))
        .buffer
        .asUint8List();
    _haircutStreamController.sink.add([
      HaircutModel(null, bytes, 'my haircut'),
      HaircutModel(null, bytes, 'my haircut'),
    ]);
  }

  @override
  Stream<List<HaircutModel>?> get haircutStream =>
      _haircutStreamController.stream;
}
