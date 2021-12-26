import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:craft_cuts_mobile/booking/data/mappers/appointment_hour_entity_mapper.dart';
import 'package:craft_cuts_mobile/booking/data/mappers/barber_entity_mapper.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/appointment_hour.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/barber.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/errors/barber_fetch_failed.dart';
import 'package:craft_cuts_mobile/booking/domain/repositories/barber_repository.dart';
import 'package:craft_cuts_mobile/common/config/api_config.dart';
import 'package:craft_cuts_mobile/common/utils/http_response_utils.dart';
import 'package:craft_cuts_mobile/common/utils/http_utils.dart';
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
      await _processBarbersResponse(response);
    } catch (e) {
      throw BarberFetchFailed(description: e.toString());
    }
  }

  Future<void> _processBarbersResponse(http.Response response) async {
    if (response.statusCode == HttpStatus.ok) {
      await _processBarbersResponseOK(response);
    } else {
      _processBarbersResponseFailed(response);
    }
  }

  Future<void> _processBarbersResponseOK(http.Response response) async {
    final decodedResponse = HttpResponseUtils.parseHttpResponseAsList(response);
    final rootList = decodedResponse;
    final barbers =
        rootList.map((row) => BarberEntityMapper.fromJson(row)).toList();

    final barbersWithHours = <Barber>[];
    for (final barber in barbers) {
      final appointments = await _fetchBarberAppointmentHours(barber);
      barbersWithHours
          .add(barber.copyWith(appointmentHours: () => appointments));
    }

    _barbersController.sink.add(barbersWithHours);
  }

  void _processBarbersResponseFailed(http.Response response) {
    //final decodedBody = HttpResponseUtils.parseHttpResponse(response);
    //final parsedReason = decodedBody['message'] as String?;
    //throw BarberFetchFailed(description: parsedReason);

    throw BarberFetchFailed(description: utf8.decode(response.bodyBytes));
  }

  Future<List<AppointmentHour>> _fetchBarberAppointmentHours(
    Barber barber,
  ) async {
    try {
      final requestUri = _appointmentHoursEndpointForBarber(barber);
      final response = await _client.get(requestUri);

      final responseHandler = HttpResponseHandler<List<AppointmentHour>>(
        response,
        onOK: (response) {
          final decodedResponse =
              HttpResponseUtils.parseHttpResponseAsList(response);
          final rootList = decodedResponse;
          final appointmentHours = rootList
              .map((row) => AppointmentHourEntityMapper.fromJson(row))
              .toList();
          return appointmentHours;
        },
      );

      if (responseHandler.isError ?? true) {
        throw BarberFetchFailed(description: responseHandler.errorDescription);
      } else {
        return responseHandler.result!;
      }
    } catch (e) {
      throw BarberFetchFailed(description: e.toString());
    }
  }

  Uri _appointmentHoursEndpointForBarber(Barber barber) =>
      Uri.https(Api.baseUrl, 'api/Date/${barber.barberId}');
}
