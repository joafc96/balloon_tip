import 'package:flutter/material.dart';

import '../index.dart';
import 'index.dart';

class OverlayArrow extends StatelessWidget {
    // @optional
  /// [color] background color applied for the arrow
  final Color? color;

  // @optional
  /// [position] position of the arrow where it has to be rendered
  final ArrowPosition position;

  // @optional
  /// [width] width of the arrow
  final double width;

  // @optional
  /// [height] height of the arrow
  final double height;

  // @optional
  /// [fadeAnimation] Animation tween applid to the overlay
  final Animation<double> fadeAnimation;

  // @optional
  /// [semanticsLabel] An optional semanticsLabel to be provided for automation team
  final String? semanticsLabel;

  const OverlayArrow({
    required this.position,
    required this.width,
    required this.height,
    required this.fadeAnimation,
    this.color,
    this.semanticsLabel,
    super.key,
  });

  /// Applies the transformation to the triangle
  Widget _getTriangle() {
    int quarterTurns = 0;

    switch (position) {
      case ArrowPosition.topLeft:
      case ArrowPosition.topCenter:
      case ArrowPosition.topRight:
        quarterTurns = 2;
        break;
      case ArrowPosition.bottomLeft:
      case ArrowPosition.bottomCenter:
      case ArrowPosition.bottomRight:
        break;
    }

    return RotatedBox(
      quarterTurns: quarterTurns,
      child: CustomPaint(
        size: Size(width, height),
        painter: TrianglePainter(strokeColor: color ?? Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: semanticsLabel,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: _getTriangle(),
      ),
    );
  }
}
