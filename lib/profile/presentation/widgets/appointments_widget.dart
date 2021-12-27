import 'package:craft_cuts_mobile/booking/domain/entities/barber.dart';
import 'package:craft_cuts_mobile/booking/presentation/state/barber_notifier.dart';
import 'package:craft_cuts_mobile/profile/presentation/state/appointments_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppointmentsWidget extends StatefulWidget {
  const AppointmentsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppointmentsWidgetState();
}

class _AppointmentsWidgetState extends State<AppointmentsWidget> {
  @override
  Widget build(BuildContext context) {
    final appointmentsNotifier = Provider.of<AppointmentsNotifier>(context);
    final barberNotifier = Provider.of<BarberNotifier>(context);

    final appointments = appointmentsNotifier.appointments;

    if (appointmentsNotifier.isLoading || appointments == null) {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final barbers = barberNotifier.barbers;

    return ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final dateFormat = DateFormat.yMMMd('ru');
        final appointment = appointments[index];
        final barberWithId = _barberWithId(barbers ?? [], appointment.barberId);

        if (barberWithId == null) {
          return Container();
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Image.network(barberWithId.photoName),
                  ),
                  title: Text(barberWithId.name),
                  subtitle: Text(
                    '${appointment.price.toString()} грн.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Chip(
                  label: Text(dateFormat.format(appointment.date!)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Barber? _barberWithId(List<Barber> barbers, int? barberId) {
    bool withSameId(Barber barber) => barber.barberId == barberId;

    try {
      return barbers.firstWhere(withSameId);
    } on StateError {
      return null;
    }
  }
}
