import 'package:craft_cuts_mobile/booking/presentation/widgets/booking_start_page.dart';
import 'package:craft_cuts_mobile/booking/presentation/widgets/booking_stepper_page.dart';
import 'package:flutter/material.dart';

class BookingPagePageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookingPagePageViewState();
}

class _BookingPagePageViewState extends State<BookingPagePageView> {
  static const _startPageIndex = 0;
  static const _stepperPageIndex = 1;
  final _pageController = PageController(initialPage: _startPageIndex);

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        BookingStartPage(
          navigateToStepperCallback: (masterFirst) {
            _pageController.jumpToPage(_stepperPageIndex);
          },
        ),
        BookingStepperPage(
          navigateBackCallback: () {
            _pageController.jumpToPage(_startPageIndex);
          },
        ),
      ],
    );
  }
}
