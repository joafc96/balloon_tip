import 'package:flutter/material.dart';

class OverlayContainer extends StatelessWidget {
  /// [child] child of the container
  final Widget child;

  /// [color] background color applied to the container
  final Color? color;

  /// [padding] edge-insets applied to the child
  final EdgeInsets? padding;

  /// [minWidth] minimum width applied to the container
  /// default value is 80
  final double? minWidth;

  /// [maxWidth] maximum width applied to the container
  /// default value is 160
  final double? maxWidth;

  /// [fadeAnimation] Animation tween applied to the overlay
  final Animation<double> fadeAnimation;

  /// [onBackPressed] function which triggers while user clicks the close icon
  final VoidCallback? onBackPressed;

  /// @optional
  /// [semanticsLabel] An optional semanticsLabel to be provided for automation
  final String? semanticsLabel;

  const OverlayContainer({
    required this.child,
    required this.fadeAnimation,
    this.maxWidth,
    this.minWidth,
    this.onBackPressed,
    this.color,
    this.padding,
    this.semanticsLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: Material(
        type: MaterialType.transparency,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: GestureDetector(
            onTap: onBackPressed,
            child: Container(
              color: color ?? Colors.black,
              padding: padding,
              constraints: BoxConstraints(
                minWidth: minWidth ?? 80,
                maxWidth: maxWidth ?? 160,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
