import 'package:flutter/widgets.dart';

class TrianglePainter extends CustomPainter {
  /// [strokeColor] color applied to the triangle
  final Color strokeColor;

  /// [paintingStyle] style applied to the trianle
  ///  default value is .fill
  final PaintingStyle paintingStyle;

  /// [strokeWidth] width applied to the stroke
  /// default value is 1
  final double strokeWidth;

  TrianglePainter({
    required this.strokeColor,
    this.strokeWidth = 1,
    this.paintingStyle = PaintingStyle.fill,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..lineTo(x, 0)
      ..lineTo(x / 2, y)
      ..close();
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
