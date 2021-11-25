import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:craft_cuts_mobile/home/presentation/widgets/home_page_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const _homePageIndex = 0;
  static const _servicesPageIndex = 1;
  static const _mastersPageIndex = 2;
  static const _profilePageIndex = 3;

  final _pageController = PageController(initialPage: _homePageIndex);
  int _currentPageIndex = _homePageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomePagePageView(
              pageController: _pageController,
            ),
            Scaffold(
              appBar: AppBar(
                title: Text(CommonStrings.services),
              ),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text(CommonStrings.book),
              ),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text(CommonStrings.profile),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: _onBottomNavigationBarTap,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              color: _getBottomNavigationItemColor(_homePageIndex),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/flame.svg',
              color: _getBottomNavigationItemColor(_servicesPageIndex),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/calendar.svg',
              color: _getBottomNavigationItemColor(_mastersPageIndex),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/profile.svg',
              color: _getBottomNavigationItemColor(_profilePageIndex),
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  Color _getBottomNavigationItemColor(int index) =>
      _currentPageIndex == index ? Colors.red : Colors.black;

  void _onBottomNavigationBarTap(int index) {
    setState(() {
      _currentPageIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
