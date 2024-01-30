import '../models/index.dart';

class PositionStrategyParams {
  /// [arrowBox] width, height, position x and y of the arrow.
  final ElementBox arrowBox;

  /// [triggerBox] width, height, position x and y of the trigger.
  final ElementBox triggerBox;

  /// [overlayBox] width, height, position x and y of the overlay.
  final ElementBox overlayBox;

  /// [distance] between the tooltip and the trigger button.
  final double distance;

  PositionStrategyParams({
    required this.arrowBox,
    required this.triggerBox,
    required this.overlayBox,
    this.distance = 0,
  });
}
