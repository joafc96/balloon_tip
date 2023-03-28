import 'package:balloon_tip/src/utils/index.dart';
import 'package:balloon_tip/src/views/index.dart';
import 'package:flutter/widgets.dart';

/// Loads the arrow from the paint code and applies the correct transformations
/// color, rotation and mirroring
class OverlayArrow extends StatelessWidget {
  /// [color] background color applied for the arrow
  final Color color;

  /// [position] position of the arrow where it has to be rendered
  final ArrowPosition position;

  /// [width] width of the arrow
  final double width;

  /// [height] height of the arrow
  final double height;

  const OverlayArrow({
    required this.position,
    required this.color,
    this.width = Constants.arrowWidth,
    this.height = Constants.arrowHeight,
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
        painter: TrianglePainter(strokeColor: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getTriangle();
  }
}
