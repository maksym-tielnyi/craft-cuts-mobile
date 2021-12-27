import 'dart:async';
import 'dart:io';

import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/booking/data/mappers/appointment_entity_mapper.dart';
import 'package:craft_cuts_mobile/booking/data/mappers/booking_entity_mapper.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/appointment.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/booking.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/errors/appointments_fetch_failed.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/errors/booking_failed.dart';
import 'package:craft_cuts_mobile/booking/domain/repositories/booking_repository.dart';
import 'package:craft_cuts_mobile/common/config/api_config.dart';
import 'package:craft_cuts_mobile/common/utils/http_utils.dart';
import 'package:http/http.dart' as http;

class BookingRepositoryImpl extends BookingRepository {
  static const _unencodedBookingPath = 'api/Booking';
  final _client = http.Client();

  final _appointmentsController = StreamController<List<Appointment>>();

  @override
  Future<bool> addBooking(Booking booking, User user) async {
    try {
      final requestUri = Uri.https(Api.baseUrl, _unencodedBookingPath);
      final bodyJson = BookingEntityMapper()
          .toJson(
            booking,
            user: user,
          )
          .toString();
      final response = await _client.post(
        requestUri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: bodyJson,
      );
      final responseHandler = HttpResponseHandler<void>(response, onOK: (_) {});
      if (responseHandler.isError ?? true) {
        throw BookingFailed(description: responseHandler.errorDescription);
      }
      return true;
    } catch (e) {
      throw BookingFailed(description: e.toString());
    }
  }

  @override
  Stream<List<Appointment>> get appointmentsStream =>
      _appointmentsController.stream;

  @override
  Future<void> fetchAppointments(User user) async {
    try {
      final requestUri = Uri.https(Api.baseUrl, _unencodedBookingPath);
      final response = await _client.get(requestUri);
      final responseHandler = HttpResponseHandler<List<Appointment>>(
        response,
        onOK: (response) {
          return AppointmentEntityMapper().fromJsonList(response.body);
        },
      );
      if (responseHandler.isError ?? true || responseHandler.result == null) {
        throw AppointmentsFetchFailed(
            description: responseHandler.errorDescription);
      }

      final appointmentsFiltered =
          _filterAppointmentsByCustomer(responseHandler.result!, user);
      _appointmentsController.sink.add(appointmentsFiltered);
    } catch (e) {
      throw AppointmentsFetchFailed(description: e.toString());
    }
  }

  List<Appointment> _filterAppointmentsByCustomer(
      List<Appointment> appointments, User customer) {
    bool refersToCustomer(Appointment appointment) =>
        appointment.customerId != null &&
        appointment.customerId == customer.userId;

    return appointments.where(refersToCustomer).toList();
  }
}
