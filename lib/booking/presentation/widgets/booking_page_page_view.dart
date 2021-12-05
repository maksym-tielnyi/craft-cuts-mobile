import 'package:craft_cuts_mobile/booking/presentation/state/booking_notifier.dart';
import 'package:craft_cuts_mobile/booking/presentation/widgets/booking_error_widget.dart';
import 'package:craft_cuts_mobile/booking/presentation/widgets/booking_start_page.dart';
import 'package:craft_cuts_mobile/booking/presentation/widgets/booking_stepper_page.dart';
import 'package:craft_cuts_mobile/booking/presentation/widgets/booking_successful_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingPagePageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookingPagePageViewState();
}

class _BookingPagePageViewState extends State<BookingPagePageView> {
  final _pageController = PageController(initialPage: _Pages.startPage.index);

  BookingNotifier get _bookingNotifier =>
      Provider.of<BookingNotifier>(context, listen: false);

  @override
  void initState() {
    _bookingNotifier.addListener(_bookingNotifierListener);
    super.initState();
  }

  Future<void> _bookingNotifierListener() async {
    if (_bookingNotifier.lastBookingSuccessful == true) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return BookingSuccessfulWidget();
          },
        ),
      );
      _pageController.jumpToPage(_Pages.startPage.index);
    } else if (_bookingNotifier.lastError != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const BookingErrorWidget();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        BookingStartPage(
          navigateToStepperCallback: (masterFirst) {
            _pageController.jumpToPage(_Pages.stepperPage.index);
          },
        ),
        BookingStepperPage(
          navigateBackCallback: () {
            _pageController.jumpToPage(_Pages.startPage.index);
          },
          onBookingApproved: () {},
          onBookingError: () {},
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cancelSubscriptions();
    super.dispose();
  }

  void _cancelSubscriptions() {
    _bookingNotifier.removeListener(_bookingNotifierListener);
  }
}

enum _Pages {
  startPage,
  stepperPage,
}
