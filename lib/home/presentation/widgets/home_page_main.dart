import 'package:craft_cuts_mobile/common/presentation/craft_cuts_search_bar/craft_cuts_search_bar.dart';
import 'package:craft_cuts_mobile/common/presentation/strings/common_strings.dart';
import 'package:flutter/material.dart';
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
      body: SmartRefresher(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _refreshController,
        enablePullUp: true,
        enablePullDown: false,
        onLoading: widget.onPullDown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              CraftCutsSearchBar(),
            ],
          ),
        ),
      ),
    );
  }
}
