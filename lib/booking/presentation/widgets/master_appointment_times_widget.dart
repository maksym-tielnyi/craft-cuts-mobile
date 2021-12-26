import 'package:craft_cuts_mobile/booking/domain/entities/appointment_hour.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/barber.dart';
import 'package:craft_cuts_mobile/booking/presentation/state/booking_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MasterAppointmentTimesWidget extends StatelessWidget {
  final Barber barber;
  final DateTime date;
  final DateTime? selectedAppointmentHour;

  const MasterAppointmentTimesWidget(
    this.barber,
    this.date,
    this.selectedAppointmentHour, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingNotifier =
        Provider.of<BookingNotifier>(context, listen: false);

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(barber.photoName),
        ),
        title: Text(
          barber.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bookingNotifier.booking?.service?.description ?? '',
              style: Theme.of(context).textTheme.caption,
            ),
            Wrap(
              spacing: 8.0,
              children: barber.appointmentHours
                      ?.where(_isForCurrentDate)
                      .map(
                        (time) => _TimeWidget(
                          time,
                          selected: time.time == selectedAppointmentHour,
                          onTap: () {
                            bookingNotifier.time = time.time;
                          },
                        ),
                      )
                      .toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }

  bool _isForCurrentDate(AppointmentHour appointmentHour) =>
      DateUtils.isSameDay(date, appointmentHour.time);
}

class _TimeWidget extends StatelessWidget {
  final AppointmentHour appointmentHour;
  final bool selected;
  final VoidCallback onTap;

  const _TimeWidget(
    this.appointmentHour, {
    Key? key,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.Hm('ru');
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(
          dateFormat.format(appointmentHour.time),
          style: Theme.of(context).textTheme.bodyText2,
        ),
        backgroundColor:
            selected ? Theme.of(context).primaryColor.withOpacity(0.8) : null,
      ),
    );
  }
}
