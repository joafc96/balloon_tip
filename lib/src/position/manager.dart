import '../index.dart';
import '../models/index.dart';
import 'index.dart';

class PositionManager {
  /// @required
  /// [params] params the position strategy takes
  final PositionStrategyParams params;

  PositionManager({
    required this.params,
  });

  /// Load the calculated balloonTip position
  BalloonTipElementsDisplay load({ArrowPosition? preferredPosition}) {
    IPositionStrategy strategy;

    switch (preferredPosition) {
      case ArrowPosition.topLeft:
        strategy = TopLeftPositionStrategy();
        break;
      case ArrowPosition.topCenter:
        strategy = TopCenterPositionStrategy();
        break;
      case ArrowPosition.topRight:
        strategy = TopRightPositionStrategy();
        break;
      case ArrowPosition.bottomLeft:
        strategy = BottomLeftPositionStrategy();
        break;
      case ArrowPosition.bottomCenter:
        strategy = BottomCenterPositionStrategy();
        break;
      case ArrowPosition.bottomRight:
        strategy = BottomRightPositionStrategy();
        break;
      default:
        strategy = BottomCenterPositionStrategy();
        break;
    }

    return strategy.calculatePosition(params: params);
  }
}
