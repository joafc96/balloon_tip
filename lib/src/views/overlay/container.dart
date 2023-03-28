import 'package:balloon_tip/src/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Bubble serves as the tooltip container
class OverlayContainer extends StatelessWidget {
  /// [color] background color applied to the container
  final Color color;

  /// [padding] edgeinsets applied to the child
  final EdgeInsets padding;

  /// [maxWidth] maximum width applied to the container
  /// deafault value is 200
  final double maxWidth;

  /// [child] child of the container
  final Widget child;

  const OverlayContainer({
    required this.child,
    required this.color,
    this.padding = Constants.overlayContainerPadding,
    this.maxWidth = Constants.overlayContainerMaxWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: color,
        padding: padding,
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
