import 'package:craft_cuts_mobile/booking/presentation/widgets/master_tile.dart';
import 'package:craft_cuts_mobile/booking/presentation/widgets/service_tile.dart';
import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:flutter/material.dart';

class BookingStepperPage extends StatefulWidget {
  final bool masterFirst;
  final VoidCallback? navigateBackCallback;

  const BookingStepperPage(
      {Key? key, this.masterFirst = false, this.navigateBackCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookingStepperPageState();
}

class _BookingStepperPageState extends State<BookingStepperPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CommonStrings.book),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          setState(() {
            _currentStep++;
          });
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
}

enum _BookingSteps {
  masters,
  service,
}
