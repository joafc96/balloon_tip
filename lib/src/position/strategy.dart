import '../index.dart';
import '../models/index.dart';
import 'index.dart';

abstract class IPositionStrategy {
  double _half(double size) => size * 0.5;

  BalloonTipElementsDisplay calculatePosition({
    required PositionStrategyParams params,
  });
}

class BottomLeftPositionStrategy extends IPositionStrategy {
  @override
  BalloonTipElementsDisplay calculatePosition({
    required PositionStrategyParams params,
  }) {
    return BalloonTipElementsDisplay(
      arrow: ElementBox.rect(
        w: params.arrowBox.w,
        h: params.arrowBox.h,
        x: _half(params.triggerBox.w).floorToDouble(),
        y: (-params.arrowBox.h - params.distance).floorToDouble(),
      ),
      container: ElementBox.rect(
        w: params.overlayBox.w,
        h: params.overlayBox.h,
        x: (_half(params.triggerBox.w) - (params.overlayBox.w * 0.07))
            .floorToDouble(),
        y: -(params.overlayBox.h + params.arrowBox.h + params.distance)
            .floorToDouble(),
      ),
      position: ArrowPosition.bottomLeft,
    );
  }
}

class BottomCenterPositionStrategy extends IPositionStrategy {
  @override
  BalloonTipElementsDisplay calculatePosition({
    required PositionStrategyParams params,
  }) {
    return BalloonTipElementsDisplay(
      arrow: ElementBox.rect(
        w: params.arrowBox.w,
        h: params.arrowBox.h,
        x: _half(params.triggerBox.w).floorToDouble(),
        y: (-params.arrowBox.h - params.distance).floorToDouble(),
      ),
      container: ElementBox.rect(
        w: params.overlayBox.w,
        h: params.overlayBox.h,
        x: (_half(params.triggerBox.w) - _half(params.overlayBox.w))
            .floorToDouble(),
        y: -(params.overlayBox.h + params.arrowBox.h + params.distance)
            .floorToDouble(),
      ),
      position: ArrowPosition.bottomCenter,
    );
  }
}

class BottomRightPositionStrategy extends IPositionStrategy {
  @override
  BalloonTipElementsDisplay calculatePosition({
    required PositionStrategyParams params,
  }) {
    return BalloonTipElementsDisplay(
      arrow: ElementBox.rect(
        w: params.arrowBox.w,
        h: params.arrowBox.h,
        x: _half(params.triggerBox.w).floorToDouble(),
        y: (-params.arrowBox.h - params.distance).floorToDouble(),
      ),
      container: ElementBox.rect(
        w: params.overlayBox.w,
        h: params.overlayBox.h,
        x: (_half(params.triggerBox.w) -
                params.overlayBox.w +
                params.arrowBox.w +
                (params.overlayBox.w * 0.07))
            .floorToDouble(),
        y: -(params.overlayBox.h + params.arrowBox.h + params.distance)
            .floorToDouble(),
      ),
      position: ArrowPosition.bottomRight,
    );
  }
}

class TopLeftPositionStrategy extends IPositionStrategy {
  @override
  BalloonTipElementsDisplay calculatePosition({
    required PositionStrategyParams params,
  }) {
    return BalloonTipElementsDisplay(
      arrow: ElementBox.rect(
        w: params.arrowBox.w,
        h: params.arrowBox.h,
        x: _half(params.triggerBox.w).ceilToDouble(),
        y: (params.triggerBox.h + params.distance).ceilToDouble(),
      ),
      container: ElementBox.rect(
        w: params.overlayBox.w,
        h: params.overlayBox.h,
        x: (_half(params.triggerBox.w) - (params.overlayBox.w * 0.07))
            .ceilToDouble(),
        y: (params.triggerBox.h + params.arrowBox.h + params.distance)
            .ceilToDouble(),
      ),
      position: ArrowPosition.topLeft,
    );
  }
}

class TopCenterPositionStrategy extends IPositionStrategy {
  @override
  BalloonTipElementsDisplay calculatePosition({
    required PositionStrategyParams params,
  }) {
    return BalloonTipElementsDisplay(
      arrow: ElementBox.rect(
        w: params.arrowBox.w,
        h: params.arrowBox.h,
        x: _half(params.triggerBox.w).ceilToDouble(),
        y: (params.triggerBox.h + params.distance).ceilToDouble(),
      ),
      container: ElementBox.rect(
        w: params.overlayBox.w,
        h: params.overlayBox.h,
        x: (_half(params.triggerBox.w) - _half(params.overlayBox.w))
            .ceilToDouble(),
        y: (params.triggerBox.h + params.arrowBox.h + params.distance)
            .ceilToDouble(),
      ),
      position: ArrowPosition.topCenter,
    );
  }
}

class TopRightPositionStrategy extends IPositionStrategy {
  @override
  BalloonTipElementsDisplay calculatePosition({
    required PositionStrategyParams params,
  }) {
    return BalloonTipElementsDisplay(
      arrow: ElementBox.rect(
        w: params.arrowBox.w,
        h: params.arrowBox.h,
        x: _half(params.triggerBox.w).ceilToDouble(),
        y: (params.triggerBox.h + params.distance).ceilToDouble(),
      ),
      container: ElementBox.rect(
        w: params.overlayBox.w,
        h: params.overlayBox.h,
        x: (_half(params.triggerBox.w) -
                (params.overlayBox.w) +
                params.arrowBox.w +
                (params.overlayBox.w * 0.07))
            .ceilToDouble(),
        y: (params.triggerBox.h + params.arrowBox.h + params.distance)
            .ceilToDouble(),
      ),
      position: ArrowPosition.topRight,
    );
  }
}
