import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CraftCutsAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onNotificationsPress;
  final VoidCallback? onMenuPress;

  const CraftCutsAppBar({
    required this.title,
    this.onNotificationsPress,
    this.onMenuPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              IconButton(
                icon: SvgPicture.asset('assets/icons/notification.svg'),
                onPressed: onNotificationsPress,
              ),
            ],
          )
        ],
      ),
    );
  }
}
