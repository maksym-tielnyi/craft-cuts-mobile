import 'dart:io';

import 'package:craft_cuts_mobile/auth/domain/entities/user.dart';
import 'package:craft_cuts_mobile/booking/data/mappers/booking_entity_mapper.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/booking.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/errors/booking_failed.dart';
import 'package:craft_cuts_mobile/booking/domain/repositories/booking_repository.dart';
import 'package:craft_cuts_mobile/common/config/api_config.dart';
import 'package:craft_cuts_mobile/common/utils/http_utils.dart';
import 'package:http/http.dart' as http;

class BookingRepositoryImpl extends BookingRepository {
  static const _unencodedBookingPath = 'api/Booking';
  final _client = http.Client();

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
}
