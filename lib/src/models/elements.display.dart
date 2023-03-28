import 'package:balloon_tip/src/models/index.dart';
import 'package:balloon_tip/src/utils/index.dart';

/// [BalloonTipElementsDisplay] holds the size, and position
/// for the container and the arrow.
class ElementsDisplay {
  final ElementBox container;
  final ElementBox arrow;
  final ArrowPosition arrowPosition;

  ElementsDisplay({
    required this.container,
    required this.arrow,
    required this.arrowPosition,
  });
}
