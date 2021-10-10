import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InjectionContainer extends StatelessWidget {
  final Widget? child;

  const InjectionContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child!;
    // return MultiProvider(
    //   providers: [],
    //   child: child!,
    // );
  }
}
