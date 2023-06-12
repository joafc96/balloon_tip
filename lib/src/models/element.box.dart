import '../constants.dart';

class ElementBox {
  final double w;
  final double h;
  final double x;
  final double y;

  ElementBox.rect({
    required this.w,
    required this.h,
    this.x = 0.0,
    this.y = 0.0,
  });

  ElementBox.zero()
      : w = 0,
        h = 0,
        x = 0,
        y = 0;

  ElementBox.point({
    required this.x,
    required this.y,
  })  : w = 0,
        h = 0;

  ElementBox.arrow()
      : w = BalloonTipConstants.arrowWidth,
        h = BalloonTipConstants.arrowHeight,
        x = 0,
        y = 0;
}
