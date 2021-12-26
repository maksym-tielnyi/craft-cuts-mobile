import 'package:copy_with_utils/copy_with_utils.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/appointment_hour.dart';

class Barber {
  final int barberId;
  final String email;
  final String name;
  final String photoName;
  final List<AppointmentHour>? appointmentHours;

  Barber(
    this.barberId,
    this.email,
    this.name,
    this.photoName, {
    this.appointmentHours,
  });

  Barber copyWith({
    ValueCallback<int>? barberId,
    ValueCallback<String>? email,
    ValueCallback<String>? name,
    ValueCallback<String>? photoName,
    ValueCallback<List<AppointmentHour>?>? appointmentHours,
  }) =>
      Barber(
        switcher(barberId, this.barberId),
        switcher(email, this.email),
        switcher(name, this.name),
        switcher(photoName, this.photoName),
        appointmentHours: switcher(appointmentHours, this.appointmentHours),
      );
}
