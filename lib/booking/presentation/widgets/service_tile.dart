import 'package:craft_cuts_mobile/booking/domain/entities/service.dart';
import 'package:craft_cuts_mobile/booking/presentation/state/booking_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceTile extends StatelessWidget {
  final Service _service;

  const ServiceTile(
    this._service, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingNotifier = Provider.of<BookingNotifier>(context);

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: RadioListTile(
        value: _service == bookingNotifier.booking?.service,
        groupValue: true,
        onChanged: (_) {
          bookingNotifier.service = _service;
        },
        title: Text(
          _service.name,
          style: Theme.of(context).textTheme.headline4,
        ),
        subtitle: Text(
          '${_service.price} грн.',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
