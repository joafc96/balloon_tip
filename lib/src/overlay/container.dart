import 'package:flutter/material.dart';

import '../constants.dart';

class OverlayContainer extends StatelessWidget {
  /// [child] child of the container
  final Widget child;

  /// [color] background color applied to the container
  final Color? color;

  /// [padding] edgeinsets applied to the child
  final EdgeInsets? padding;

  /// [maxWidth] maximum width applied to the container
  /// deafault value is 160
  final double? maxWidth;

  /// [minWidth] minimum width applied to the container
  /// deafault value is 80
  final double? minWidth;

  /// [onBackPressed] function which triggers while user clicks the close icon
  final VoidCallback? onBackPressed;

  /// [fadeAnimation] Animation tween applid to the overlay
  final Animation<double> fadeAnimation;

  // @optional
  /// [semanticsLabel] An optional semanticsLabel to be provided for automation team
  final String? semanticsLabel;

  const OverlayContainer({
    required this.child,
    required this.fadeAnimation,
    this.color,
    this.onBackPressed,
    this.padding,
    this.maxWidth,
    this.minWidth,
    this.semanticsLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: semanticsLabel,
      child: Material(
        type: MaterialType.transparency,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Container(
            color: color ?? Colors.black,
            padding: padding ?? BalloonTipConstants.overlayContainerPadding,
            constraints: BoxConstraints(
              minWidth:
                  minWidth ?? BalloonTipConstants.overlayContainerMinWidth,
              maxWidth:
                  maxWidth ?? BalloonTipConstants.overlayContainerMaxWidth,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
