import 'package:craft_cuts_mobile/haircut_demo/presentation/state/haircut_demo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetPhotoWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const GetPhotoWidget({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final haircutDemoNotifier =
        Provider.of<HaircutDemoNotifier>(context, listen: false);

    return Container(
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              haircutDemoNotifier.getModelPhotoFromGallery();
              onPressed!();
            },
            icon: Icon(Icons.image),
          ),
          IconButton(
            onPressed: () {
              haircutDemoNotifier.getModelPhotoFromCamera();
              onPressed!();
            },
            icon: Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
