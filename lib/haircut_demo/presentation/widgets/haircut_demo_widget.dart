import 'package:carousel_slider/carousel_slider.dart';
import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:craft_cuts_mobile/haircut_demo/presentation/state/haircut_demo_notifier.dart';
import 'package:craft_cuts_mobile/haircut_demo/presentation/widgets/get_photo_widget.dart';
import 'package:craft_cuts_mobile/haircut_demo/presentation/widgets/model_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HaircutDemoWidget extends StatefulWidget {
  const HaircutDemoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HaircutDemoWidgetState();
}

class _HaircutDemoWidgetState extends State<HaircutDemoWidget> {
  late HaircutDemoNotifier _haircutDemoNotifier;
  bool _isHaircutsInitialized = false;

  @override
  Widget build(BuildContext context) {
    _haircutDemoNotifier = Provider.of<HaircutDemoNotifier>(context);

    if (!_isHaircutsInitialized) {
      _haircutDemoNotifier.fetchHaircuts();
      _isHaircutsInitialized = true;
    }

    final haircuts = _haircutDemoNotifier.haircutsViewModel.haircuts;
    const int bonusEmptyHaircut = 1;
    final haircutCarouselLength = haircuts == null
        ? bonusEmptyHaircut
        : haircuts.length + bonusEmptyHaircut;

    return Column(
      children: [
        Expanded(
          child: GestureDetector(
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
            child: Stack(
              children: [
                const ModelImageWidget(),
                if (_haircutDemoNotifier.isLoading)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 100.0,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider.builder(
            itemCount: haircutCarouselLength,
            itemBuilder: (_, index, __) {
              if (index == haircutCarouselLength - 1) {
                return Center(
                  child: Text(CommonStrings.empty),
                );
              }
              return Image.asset(
                  'assets/images/haircuts/${haircuts![index].imageName}.png');
            },
            options: CarouselOptions(onPageChanged: (index, _) async {
              await _haircutDemoNotifier
                  .handleSelectedHaircutChanged(haircuts![index]);
            }),
          ),
        ),
      ],
    );
  }
}
