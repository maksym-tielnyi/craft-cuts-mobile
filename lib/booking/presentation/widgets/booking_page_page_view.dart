import 'package:craft_cuts_mobile/booking/presentation/widgets/booking_start_page.dart';
import 'package:flutter/material.dart';

class BookingPagePageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookingPagePageViewState();
}

class _BookingPagePageViewState extends State<BookingPagePageView> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        BookingStartPage(),
      ],
    );
  }
}
