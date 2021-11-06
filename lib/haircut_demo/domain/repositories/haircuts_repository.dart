import 'package:craft_cuts_mobile/haircut_demo/data/models/haircut_model.dart';

abstract class HaircutsRepository {
  Stream<List<HaircutModel>?> get haircutStream;

  Future<void> fetchHaircuts();
}
