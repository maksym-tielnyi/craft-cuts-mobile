import 'package:craft_cuts_mobile/auth/presentation/state/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InjectionContainer extends StatelessWidget {
  final Widget? child;
  final _authNotifier = AuthNotifier();

  InjectionContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authNotifier),
      ],
      child: child!,
    );
  }
}
