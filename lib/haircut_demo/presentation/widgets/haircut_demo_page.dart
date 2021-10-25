import 'package:craft_cuts_mobile/haircut_demo/presentation/state/haircut_demo_notifier.dart';
import 'package:craft_cuts_mobile/haircut_demo/presentation/widgets/get_photo_widget.dart';
import 'package:craft_cuts_mobile/haircut_demo/presentation/widgets/haircut_demo_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HaircutDemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HaircutDemoPage();
}

class _HaircutDemoPage extends State<HaircutDemoPage> {
  @override
  Widget build(BuildContext context) {
    final haircutDemoNotifier = Provider.of<HaircutDemoNotifier>(context);
    final photoBytes = haircutDemoNotifier.modelPhotoViewModel.photoBytes;

    if (photoBytes == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetPhotoWidget(),
        ],
      );
    }
    return HaircutDemoWidget(photoBytes);
  }
}
