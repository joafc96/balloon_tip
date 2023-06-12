import 'package:flutter/material.dart';

class OverlayContainer extends StatelessWidget {
  /// [child] child of the container
  final Widget child;

  /// [color] background color applied to the container
  final Color? color;

  /// [padding] edgeinsets applied to the child
  final EdgeInsets? padding;

  /// [maxWidth] maximum width applied to the container
  /// deafault value is 160
  final double maxWidth;

  /// [minWidth] minimum width applied to the container
  /// deafault value is 80
  final double minWidth;

  /// [fadeAnimation] Animation tween applid to the overlay
  final Animation<double> fadeAnimation;

  // @optional
  /// [semanticsLabel] An optional semanticsLabel to be provided for automation team
  final String? semanticsLabel;

  const OverlayContainer({
    required this.child,
    required this.fadeAnimation,
    this.color,
    this.padding,
    required this.maxWidth,
    required this.minWidth,
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
            color: color,
            padding: padding,
            constraints: BoxConstraints(
              minWidth: minWidth,
              maxWidth: maxWidth,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
