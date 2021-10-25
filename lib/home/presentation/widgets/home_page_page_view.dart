import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:craft_cuts_mobile/home/presentation/widgets/haircut_demo_page.dart';
import 'package:craft_cuts_mobile/home/presentation/widgets/home_page_main.dart';
import 'package:flutter/material.dart';

class HomePagePageView extends StatefulWidget {
  final PageController pageController;
  const HomePagePageView({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageBody();

  static String getCurrentAppbarTitle(double? pageIndex) {
    const _pageTitles = const [
      CommonStrings.home,
      CommonStrings.onlineHaircut,
    ];
    if (pageIndex == null) {
      return _pageTitles[0];
    }
    return _pageTitles[pageIndex.round()];
  }
}

class _HomePageBody extends State<HomePagePageView> {
  static const int _mainPageIndex = 0;
  static const int _haircutDemoPageIndex = 1;

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      children: [
        HomePageMain(
          onPullDown: () async {
            await _pageController.animateToPage(
              _haircutDemoPageIndex,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
          },
        ),
        HaircutDemoPage(),
      ],
    );
  }
}
