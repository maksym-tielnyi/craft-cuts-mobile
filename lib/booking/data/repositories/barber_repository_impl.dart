import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:craft_cuts_mobile/booking/data/mappers/barber_entity_mapper.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/barber.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/errors/barber_fetch_failed.dart';
import 'package:craft_cuts_mobile/booking/domain/repositories/barber_repository.dart';
import 'package:craft_cuts_mobile/common/config/api_config.dart';
import 'package:craft_cuts_mobile/common/utils/http_response_utils.dart';
import 'package:http/http.dart' as http;

class BarberRepositoryImpl implements BarberRepository {
  static const _unencodedBarbersPath = 'api/Barber';
  final _client = http.Client();
  final _barbersController = StreamController<List<Barber>?>();

  @override
  Stream<List<Barber>?> get barbersStream => _barbersController.stream;

  @override
  Future<void> fetchBarbers() async {
    try {
      final requestUri = Uri.https(Api.baseUrl, _unencodedBarbersPath);
      final response = await _client.get(requestUri);
      _processBarbersResponse(response);
    } catch (e) {
      throw BarberFetchFailed(description: e.toString());
    }
  }

  void _processBarbersResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      _processBarbersResponseOK(response);
    } else {
      _processBarbersResponseFailed(response);
    }
  }

  void _processBarbersResponseOK(http.Response response) {
    final decodedResponse = HttpResponseUtils.parseHttpResponseAsList(response);
    final rootList = decodedResponse;
    final barbers =
        rootList.map((row) => BarberEntityMapper.fromJson(row)).toList();
    _barbersController.sink.add(barbers);
  }

  void _processBarbersResponseFailed(http.Response response) {
    //final decodedBody = HttpResponseUtils.parseHttpResponse(response);
    //final parsedReason = decodedBody['message'] as String?;
    //throw BarberFetchFailed(description: parsedReason);

    throw BarberFetchFailed(description: utf8.decode(response.bodyBytes));
  }
}
