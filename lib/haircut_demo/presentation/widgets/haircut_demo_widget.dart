import 'dart:typed_data';

import 'package:craft_cuts_mobile/haircut_demo/presentation/widgets/get_photo_widget.dart';
import 'package:flutter/material.dart';

class HaircutDemoWidget extends StatefulWidget {
  final Uint8List imageBytes;

  const HaircutDemoWidget(
    this.imageBytes, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HaircutDemoWidgetState();
}

class _HaircutDemoWidgetState extends State<HaircutDemoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                children: [
                  GetPhotoWidget(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
          child: Image.memory(widget.imageBytes),
        )
      ],
    );
  }
}
