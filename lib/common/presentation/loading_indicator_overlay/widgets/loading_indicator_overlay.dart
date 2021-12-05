import 'package:flutter/material.dart';

class LoadingIndicatorOverlay extends StatelessWidget {
  final Widget? child;
  final bool isLoading;

  const LoadingIndicatorOverlay({
    required this.isLoading,
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: [
          if (child != null) child!,
          if (isLoading)
            Stack(
              children: [
                Positioned.fill(
                  child: ModalBarrier(
                    color: Colors.black.withOpacity(0.5),
                    dismissible: false,
                  ),
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
