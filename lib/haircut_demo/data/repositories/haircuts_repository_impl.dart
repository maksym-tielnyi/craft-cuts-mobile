import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:craft_cuts_mobile/haircut_demo/data/models/haircut_model.dart';
import 'package:craft_cuts_mobile/haircut_demo/domain/repositories/haircuts_repository.dart';
import 'package:http/http.dart' as http;

class HaircutsRepositoryImpl implements HaircutsRepository {
  static const _apiEndpoint =
      'craftcutstestapiproject20211011184405.azurewebsites.net';
  static const _unencodedHaircutsPath = 'api/Haircut';

  final _client = http.Client();
  final _haircutStreamController = StreamController<List<HaircutModel>?>();

  @override
  Future<void> fetchHaircuts() async {
    final requestUri = Uri.https(
      _apiEndpoint,
      _unencodedHaircutsPath,
    );

    final response = await _client.get(requestUri);
    _processHaircutsResponse(response);
  }

  void _processHaircutsResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      _processFetchOK(response);
    } else {
      _processFetchFail(response);
    }
  }

  void _processFetchOK(http.Response response) {
    final decodedResponse = _parseHttpResponse(response);
    final haircuts = HaircutModel.fromJsonList(decodedResponse);
    _haircutStreamController.sink.add(haircuts);
  }

  void _processFetchFail(http.Response response) {}

  String _parseHttpResponse(http.Response response) {
    final decodedString = utf8.decode(response.bodyBytes);
    return decodedString;
  }

  @override
  Stream<List<HaircutModel>?> get haircutStream =>
      _haircutStreamController.stream;
}
