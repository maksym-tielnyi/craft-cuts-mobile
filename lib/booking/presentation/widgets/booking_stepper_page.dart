import 'package:craft_cuts_mobile/booking/presentation/state/booking_notifier.dart';
import 'package:craft_cuts_mobile/booking/presentation/widgets/master_tile.dart';
import 'package:craft_cuts_mobile/booking/presentation/widgets/service_tile.dart';
import 'package:craft_cuts_mobile/common/presentation/loading_indicator_overlay/widgets/loading_indicator_overlay.dart';
import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingStepperPage extends StatefulWidget {
  final bool masterFirst;
  final VoidCallback? navigateBackCallback;
  final VoidCallback? onBookingApproved;
  final VoidCallback? onBookingError;

  const BookingStepperPage({
    Key? key,
    this.masterFirst = false,
    this.navigateBackCallback,
    this.onBookingApproved,
    this.onBookingError,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookingStepperPageState();
}

class _BookingStepperPageState extends State<BookingStepperPage> {
  int _currentStep = 0;

  BookingNotifier get _bookingNotifier =>
      Provider.of<BookingNotifier>(context, listen: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _bookingNotifier = Provider.of<BookingNotifier>(context);

    return LoadingIndicatorOverlay(
      isLoading: _bookingNotifier.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(CommonStrings.book),
        ),
        body: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepContinue: () async {
            if (_currentStep == _BookingSteps.dateTime.index) {
              await _bookingNotifier.confirmBooking();
            } else {
              setState(() {
                _currentStep++;
              });
            }
          },
          onStepCancel: () {
            setState(() {
              _currentStep--;
            });
          },
          controlsBuilder: (
            BuildContext context, {
            VoidCallback? onStepContinue,
            VoidCallback? onStepCancel,
          }) {
            return Row(
              children: [
                TextButton(
                  onPressed: onStepContinue,
                  child: const Text('Продолжить'),
                ),
                if (_currentStep != 0)
                  TextButton(
                    onPressed: onStepCancel,
                    child: const Text('Назад'),
                  ),
              ],
            );
          },
          steps: _buildSteps(_currentStep),
        ),
      ),
    );
  }

  List<Step> _buildSteps(int index) {
    return <Step>[
      Step(
        isActive: index == _BookingSteps.masters.index,
        state: _getStepState(_BookingSteps.masters.index),
        title: Text(
          CommonStrings.chooseSpecialist,
          style: Theme.of(context).textTheme.headline4,
        ),
        content: Expanded(
          child: Column(
            children: [
              ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (_, index) => MasterTile(),
              ),
            ],
          ),
        ),
      ),
      Step(
        isActive: index == _BookingSteps.service.index,
        state: _getStepState(_BookingSteps.service.index),
        title: Container(
          child: Text(
            CommonStrings.chooseVariant,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        content: Column(
          children: [
            ExpansionTile(
              title: Text(
                CommonStrings.haircut,
                style: Theme.of(context).textTheme.headline3,
              ),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (_, index) => ServiceTile(),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                CommonStrings.painting,
                style: Theme.of(context).textTheme.headline3,
              ),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (_, index) => ServiceTile(),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                CommonStrings.beard,
                style: Theme.of(context).textTheme.headline3,
              ),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (_, index) => ServiceTile(),
                ),
              ],
            ),
          ],
        ),
      ),
      Step(
        isActive: index == _BookingSteps.dateTime.index,
        state: _getStepState(_BookingSteps.dateTime.index),
        title: Container(
          child: Text(
            CommonStrings.selectDateAndTime,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/icons/date.svg',
                    color: Colors.red,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50.0,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (_, index) {
                          final format = DateFormat.yMd('ru');

                          return GestureDetector(
                            child: Padding(
                              padding: EdgeInsetsDirectional.all(5.0),
                              child: Text(
                                format
                                    .format(DateUtils.dateOnly(DateTime.now())),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  CommonStrings.time,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (_, index) {
                  return MasterTile();
                },
              ),
            ),
          ],
        ),
      ),
    ];
  }

  StepState _getStepState(int index) {
    if (index < _currentStep) {
      return StepState.disabled;
    } else if (index > _currentStep) {
      return StepState.indexed;
    }
    return StepState.editing;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum _BookingSteps {
  masters,
  service,
  dateTime,
}
