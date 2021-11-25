import 'dart:io';

import 'package:craft_cuts_mobile/haircut_demo/presentation/state/haircut_demo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:provider/provider.dart';

class ModelImageWidget extends StatefulWidget {
  const ModelImageWidget();

  @override
  State<StatefulWidget> createState() => _ModelImageWidgetState();
}

class _ModelImageWidgetState extends State<ModelImageWidget> {
  @override
  Widget build(BuildContext context) {
    final haircutNotifier = Provider.of<HaircutDemoNotifier>(context);

    return Stack(
      children: <Widget>[
        Image.file(File(haircutNotifier.modelPhotoViewModel.image!.path))
      ]..addAll(_generateHaircutWidgets()),
    );
  }

  List<Widget> _generateHaircutWidgets() {
    final haircutNotifier =
        Provider.of<HaircutDemoNotifier>(context, listen: false);
    final modelPhotoViewModel = haircutNotifier.modelPhotoViewModel;

    if ((modelPhotoViewModel.faces?.isEmpty ?? true) ||
        modelPhotoViewModel.imageSize == null ||
        modelPhotoViewModel.selectedHaircut == null) {
      return <Widget>[];
    }

    final haircutPath =
        haircutNotifier.modelPhotoViewModel.selectedHaircut!.imageName;

    final haircutImageAsset = 'assets/images/haircuts/$haircutPath.png';

    final realWidth = MediaQuery.of(context).size.width;
    final coefficient =
        realWidth / haircutNotifier.modelPhotoViewModel.imageSize!.width;
    final realHeight =
        haircutNotifier.modelPhotoViewModel.imageSize!.height * coefficient;

    final widgets = List<Widget>.generate(
      haircutNotifier.modelPhotoViewModel.faces!.length,
      (index) {
        final face = haircutNotifier.modelPhotoViewModel.faces![index];
        final leftEar = face.getLandmark(FaceLandmarkType.leftEar);
        final rightEar = face.getLandmark(FaceLandmarkType.rightEar);

        final xRelational =
            face.boundingBox.left / modelPhotoViewModel.imageSize!.width;
        final yRelational =
            leftEar!.position.dy / modelPhotoViewModel.imageSize!.height;

        final widthRelational =
            face.boundingBox.width / modelPhotoViewModel.imageSize!.width;
        final heightRelational =
            face.boundingBox.height / modelPhotoViewModel.imageSize!.height;

        final height = realHeight * heightRelational;

        return Positioned(
          left: realWidth * xRelational,
          top: realHeight * yRelational - height,
          width: realWidth * widthRelational,
          height: height,
          child: Image.asset(haircutImageAsset),
        );
      },
    );
    return widgets;
  }
}
