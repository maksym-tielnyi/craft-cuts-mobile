import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:craft_cuts_mobile/booking/data/mappers/service_entity_mapper.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/errors/service_fetch_failed.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/service.dart';
import 'package:craft_cuts_mobile/booking/domain/repositories/service_repository.dart';
import 'package:craft_cuts_mobile/common/config/api_config.dart';
import 'package:craft_cuts_mobile/common/utils/http_response_utils.dart';
import 'package:http/http.dart' as http;

class ServiceRepositoryImpl implements ServiceRepository {
  static const _unencodedServicesPath = 'api/Service';
  final _client = http.Client();
  final _servicesController = StreamController<List<Service>?>();

  @override
  Future<void> fetchServices() async {
    try {
      final requestUri = Uri.https(Api.baseUrl, _unencodedServicesPath);
      final response = await _client.get(requestUri);
      _processServiceResponse(response);
    } catch (e) {
      throw ServiceFetchFailed(description: e.toString());
    }
  }

  void _processServiceResponse(http.Response response) {
    if (response.statusCode == HttpStatus.ok) {
      _processServicesResponseOK(response);
    } else {
      _processServicesResponseFailed(response);
    }
  }

  void _processServicesResponseOK(http.Response response) {
    final decodedResponse = HttpResponseUtils.parseHttpResponseAsList(response);
    final rootList = decodedResponse;
    final services =
        rootList.map((row) => ServiceEntityMapper.fromJson(row)).toList();
    _servicesController.sink.add(services);
  }

  void _processServicesResponseFailed(http.Response response) {
    throw ServiceFetchFailed(description: utf8.decode(response.bodyBytes));
  }

  @override
  Stream<List<Service>?> get servicesStream => _servicesController.stream;
}
