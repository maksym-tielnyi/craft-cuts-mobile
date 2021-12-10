import 'package:craft_cuts_mobile/booking/domain/entities/barber.dart';
import 'package:craft_cuts_mobile/booking/presentation/state/booking_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MasterTile extends StatelessWidget {
  final Barber _barber;

  const MasterTile(
    this._barber, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingNotifier = Provider.of<BookingNotifier>(context);

    return RadioListTile(
      value: _barber.email == bookingNotifier.booking?.masterEmail,
      onChanged: (bool? value) {
        if (true) {
          bookingNotifier.masterEmail = _barber.email;
        }
      },
      groupValue: true,
      title: SafeArea(
        child: Card(
          color: Color(0xFFE5E5E5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_barber.photoName),
            ),
            title: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  _barber.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Card(
                  shape: const StadiumBorder(),
                  elevation: 0,
                  child: SizedBox(
                    width: 100.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        verticalDirection: VerticalDirection.up,
                        children: List.generate(
                          5,
                          (index) => Expanded(
                            child: SvgPicture.asset(
                              'assets/icons/flame.svg',
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            subtitle: Text(
              'Стрижка, борода',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
