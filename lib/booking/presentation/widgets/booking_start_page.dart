import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingStartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookingStartPageState();
}

class _BookingStartPageState extends State<BookingStartPage> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(CommonStrings.book),
    //   ),
    //   body: Stepper(
    //     type: StepperType.horizontal,
    //     steps: [
    //       Step(
    //         title: Text(CommonStrings.chooseSpecialist),
    //         content: Column(
    //
    //         ),
    //       )
    //     ],
    //   ),
    // );

    final boxDecoration = BoxDecoration(
      color: Color(0xFFFFF9F1),
      borderRadius: BorderRadius.circular(10.0),
    );
    const boxHeight = 120.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(CommonStrings.book),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                children: [
                  Text(
                    CommonStrings.onlineBooking,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    CommonStrings.chooseSpecialist,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      height: boxHeight,
                      decoration: boxDecoration,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            CommonStrings.masters,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SvgPicture.asset(
                            'assets/images/booking/masters.svg',
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: boxHeight,
                      decoration: boxDecoration,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            CommonStrings.services,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SvgPicture.asset(
                            'assets/images/booking/services.svg',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
