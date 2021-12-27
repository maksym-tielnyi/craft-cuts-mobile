import 'package:craft_cuts_mobile/common/presentation/craft_cuts_search_bar/craft_cuts_search_bar.dart';
import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageMain extends StatefulWidget {
  final VoidCallback? onPullDown;

  const HomePageMain({Key? key, this.onPullDown}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          CommonStrings.home,
        ),
      ),
      body: SizedBox.expand(
        child: SmartRefresher(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _refreshController,
          enablePullUp: true,
          enablePullDown: false,
          onLoading: widget.onPullDown,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10.0),
                CraftCutsSearchBar(),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Text(
                      CommonStrings.services,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(width: 8.0),
                    SvgPicture.asset('assets/icons/flame.svg'),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/haircut_ad.png'),
                    Image.asset('assets/images/dyeing_ad.png'),
                    Image.asset('assets/images/beard_ad.png'),
                  ],
                ),
                const SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(CommonStrings.makeAnAppointment),
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    Text(
                      CommonStrings.onlineHaircut,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(width: 8.0),
                    SvgPicture.asset('assets/icons/flame.svg'),
                  ],
                ),
                Builder(
                  builder: (context) {
                    return Image.asset(
                      'assets/images/try_cut.png',
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
