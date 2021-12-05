import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingSuccessfulWidget extends StatelessWidget {
  final VoidCallback? gotoBookings;

  BookingSuccessfulWidget({
    Key? key,
    this.gotoBookings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.assignment_turned_in_rounded,
                color: Colors.green,
                size: 50.0,
              ),
              SizedBox(height: 15),
              Text(CommonStrings.bookingSuccessMessage,
                  style: Theme.of(context).textTheme.bodyText1),
              TextButton(
                onPressed: gotoBookings,
                child: Text(
                  CommonStrings.gotoBookings,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
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
