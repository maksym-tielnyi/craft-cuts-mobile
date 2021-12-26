import 'package:craft_cuts_mobile/booking/domain/entities/appointment_hour.dart';
import 'package:craft_cuts_mobile/booking/domain/entities/barber.dart';
import 'package:craft_cuts_mobile/booking/presentation/state/barber_notifier.dart';
import 'package:craft_cuts_mobile/booking/presentation/state/booking_notifier.dart';
import 'package:craft_cuts_mobile/booking/presentation/state/service_notifier.dart';
import 'package:craft_cuts_mobile/booking/presentation/widgets/master_appointment_times_widget.dart';
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
  DateTime? _selectedDate;

  BookingNotifier get _bookingNotifier =>
      Provider.of<BookingNotifier>(context, listen: false);

  BarberNotifier get _barberNotifier =>
      Provider.of<BarberNotifier>(context, listen: false);

  ServiceNotifier get _serviceNotifier =>
      Provider.of<ServiceNotifier>(context, listen: false);

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _barberNotifier.fetchBarbers();
      _serviceNotifier.fetchServices();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookingNotifier = Provider.of<BookingNotifier>(context);
    Provider.of<BarberNotifier>(context);
    Provider.of<ServiceNotifier>(context);

    return LoadingIndicatorOverlay(
      isLoading: bookingNotifier.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(CommonStrings.book),
        ),
        body: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepContinue: () async {
            if (_currentStep == _BookingSteps.dateTime.index) {
              await bookingNotifier.confirmBooking();
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
        content: Builder(builder: (context) {
          if (_barberNotifier.isLoading || _barberNotifier.barbers == null) {
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Expanded(
            child: Column(
              children: [
                ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _barberNotifier.barbers?.length,
                  itemBuilder: (_, index) =>
                      MasterTile(_barberNotifier.barbers![index]),
                ),
              ],
            ),
          );
        }),
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
        content: Builder(builder: (context) {
          if (_serviceNotifier.isLoading || _serviceNotifier.services == null) {
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Column(
            children: [
              ExpansionTile(
                title: Text(
                  CommonStrings.haircut,
                  style: Theme.of(context).textTheme.headline3,
                ),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _serviceNotifier.services?.length,
                    itemBuilder: (_, index) =>
                        ServiceTile(_serviceNotifier.services![index]),
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
                    itemCount: _serviceNotifier.services?.length,
                    itemBuilder: (_, index) =>
                        ServiceTile(_serviceNotifier.services![index]),
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
                    itemCount: _serviceNotifier.services!.length,
                    itemBuilder: (_, index) =>
                        ServiceTile(_serviceNotifier.services![index]),
                  ),
                ],
              ),
            ],
          );
        }),
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
        content: Builder(builder: (context) {
          final barbers = _barberNotifier.barbers
                  ?.where(_fitSelectedBarberEmail)
                  .toList(growable: false) ??
              [];
          final appointmentDates = <DateTime>[
            for (final barber in barbers)
              ..._distinctAppointmentDates(barber.appointmentHours ?? [])
          ];

          return Column(
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
                          itemCount: appointmentDates.length,
                          itemBuilder: (_, index) {
                            final date = appointmentDates[index];
                            return _AppointmentDateListItem(
                              date,
                              selected:
                                  DateUtils.isSameDay(date, _selectedDate),
                              onTap: () {
                                setState(() {
                                  _selectedDate = date;
                                });
                              },
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
              Builder(builder: (context) {
                final selectedDate = _selectedDate;

                if (selectedDate == null) return Container();

                return Flexible(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: barbers.length,
                    itemBuilder: (_, index) => MasterAppointmentTimesWidget(
                        barbers[index],
                        selectedDate,
                        _bookingNotifier.booking?.time),
                  ),
                );
              }),
            ],
          );
        }),
      ),
    ];
  }

  List<DateTime> _distinctAppointmentDates(List<AppointmentHour> appointments) {
    final dates = <DateTime>{};

    for (final appointment in appointments) {
      dates.add(DateUtils.dateOnly(appointment.time));
    }

    return dates.toList()..sort();
  }

  bool _fitSelectedBarberEmail(Barber barber) {
    final selectedBarber = _bookingNotifier.booking?.master;
    return selectedBarber != null && barber == selectedBarber;
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

class _AppointmentDateListItem extends StatelessWidget {
  final DateTime date;
  final bool selected;
  final VoidCallback? onTap;

  const _AppointmentDateListItem(
    this.date, {
    required this.selected,
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const locale = 'ru';
    final dateFormat = DateFormat(DateFormat.DAY);
    final weekdayFormat = DateFormat(DateFormat.ABBR_WEEKDAY, locale);
    final monthFormat = DateFormat(DateFormat.ABBR_MONTH, locale);

    final selectedColor = Theme.of(context).primaryColor;
    final textStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(color: selected ? selectedColor : null);

    return GestureDetector(
      child: Padding(
        padding: EdgeInsetsDirectional.all(5.0),
        child: Text(
          '${dateFormat.format(date)} ${weekdayFormat.format(date)}.'
          '\n${monthFormat.format(date)}',
          style: textStyle,
        ),
      ),
      onTap: onTap,
    );
  }
}
