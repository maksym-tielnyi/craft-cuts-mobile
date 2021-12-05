import 'package:craft_cuts_mobile/booking/presentation/state/booking_notifier.dart';
import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingErrorWidget extends StatelessWidget {
  const BookingErrorWidget();

  @override
  Widget build(BuildContext context) {
    final _bookingNotifier =
        Provider.of<BookingNotifier>(context, listen: false);

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
              ),
              Text(
                  _bookingNotifier.lastError?.description ??
                      CommonStrings.bookingErrorDefaultMessage,
                  style: Theme.of(context).textTheme.bodyText2),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Вернуться'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
