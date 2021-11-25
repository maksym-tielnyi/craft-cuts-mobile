import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
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
    final photoBytes = haircutDemoNotifier.modelPhotoViewModel.image;

    Widget body;

    if (photoBytes == null) {
      body = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GetPhotoWidget(),
        ],
      );
    } else {
      body = HaircutDemoWidget();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(CommonStrings.onlineHaircut),
      ),
      body: body,
    );
  }
}
