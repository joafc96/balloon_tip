
import 'package:balloon_tip/src/models/index.dart';
import 'package:balloon_tip/src/utils/index.dart';

/// Calculates the position of the tooltip and the arrow on the screen
/// Verifies if the desired position fits the screen.
/// If it doesn't the position changes automatically.
class PositionManager {
  /// [arrowBox] width, height, position x and y of the arrow.
  final ElementBox arrowBox;

  /// [triggerBox] width, height, position x and y of the trigger.
  final ElementBox triggerBox;

  /// [overlayBox] width, height, position x and y of the overlay.
  final ElementBox overlayBox;

  /// [screenSize] width and height of the current screen.
  final ElementBox screenSize;

  /// [distance] between the tooltip and the trigger button.
  final double distance;

  PositionManager({
    required this.arrowBox,
    required this.triggerBox,
    required this.overlayBox,
    required this.screenSize,
    required this.distance,
  });

  ElementsDisplay _bottomLeft() {
    return ElementsDisplay(
      arrow: ElementBox.rect(
        w: arrowBox.w,
        h: arrowBox.h,
        x: _calculateLeftArrowX(),
        y: _calculateBottomArrowY(),
      ),
      container: ElementBox.rect(
        w: overlayBox.w,
        h: overlayBox.h,
        x: _calculateLeftContainerX(),
        y: _calculateBottomContainerY(),
      ),
      arrowPosition: ArrowPosition.bottomLeft,
    );
  }

  ElementsDisplay _bottomCenter() {
    return ElementsDisplay(
      arrow: ElementBox.rect(
        w: arrowBox.w,
        h: arrowBox.h,
        x: _calculateCenterArrowX(),
        y: _calculateBottomArrowY(),
      ),
      container: ElementBox.rect(
        w: overlayBox.w,
        h: overlayBox.h,
        x: _calculateCenterContainerX(),
        y: _calculateBottomContainerY(),
      ),
      arrowPosition: ArrowPosition.bottomCenter,
    );
  }

  ElementsDisplay _bottomRight() {
    return ElementsDisplay(
      arrow: ElementBox.rect(
        w: arrowBox.w,
        h: arrowBox.h,
        x: _calculateRightArrowX(),
        y: _calculateBottomArrowY(),
      ),
      container: ElementBox.rect(
        w: arrowBox.w,
        h: arrowBox.h,
        x: _calculateRightContainerX(),
        y: _calculateBottomContainerY(),
      ),
      arrowPosition: ArrowPosition.bottomRight,
    );
  }

  ElementsDisplay _topLeft() {
    return ElementsDisplay(
      arrow: ElementBox.rect(
        w: arrowBox.w,
        h: arrowBox.h,
        x: _calculateLeftArrowX(isBottom: false),
        y: _calculateTopArrowY(),
      ),
      container: ElementBox.rect(
        w: overlayBox.w,
        h: overlayBox.h,
        x: _calculateLeftContainerX(isBottom: false),
        y: _calculateTopContainerY(),
      ),
      arrowPosition: ArrowPosition.topLeft,
    );
  }

  ElementsDisplay _topCenter() {
    return ElementsDisplay(
      arrow: ElementBox.rect(
        w: arrowBox.w,
        h: arrowBox.h,
        x: _calculateCenterArrowX(isBottom: false),
        y: _calculateTopArrowY(),
      ),
      container: ElementBox.rect(
        w: overlayBox.w,
        h: overlayBox.h,
        x: _calculateCenterContainerX(isBottom: false),
        y: _calculateTopContainerY(),
      ),
      arrowPosition: ArrowPosition.topCenter,
    );
  }

  ElementsDisplay _topRight() {
    return ElementsDisplay(
      arrow: ElementBox.rect(
        w: arrowBox.w,
        h: arrowBox.h,
        x: _calculateRightArrowX(isBottom: false),
        y: _calculateTopArrowY(),
      ),
      container: ElementBox.rect(
        w: overlayBox.w,
        h: overlayBox.h,
        x: _calculateRightContainerX(isBottom: false),
        y: _calculateTopContainerY(),
      ),
      arrowPosition: ArrowPosition.topRight,
    );
  }

  double _half(double size) {
    return size * 0.5;
  }

  /// As x value increases from left to right of the device screen,
  /// if isLeft floor the x value.
  /// else ceil the x value.
  double _calculateLeftArrowX({bool isBottom = true}) {
    final x = (triggerBox.x + _half(triggerBox.w) - _half(arrowBox.w));
    if (isBottom) {
      return x.floorToDouble();
    } else {
      return x.ceilToDouble();
    }
  }

  double _calculateLeftContainerX({bool isBottom = true}) {
    final x = triggerBox.x +
        _half(triggerBox.w) -
        _half(arrowBox.w) -
        (overlayBox.w * 0.07);

    if (isBottom) {
      return x.floorToDouble();
    } else {
      return x.ceilToDouble();
    }
  }

  double _calculateRightArrowX({bool isBottom = true}) {
    final x = (triggerBox.x + _half(triggerBox.w) - _half(arrowBox.w));

    if (isBottom) {
      return x.floorToDouble();
    } else {
      return x.ceilToDouble();
    }
  }

  double _calculateRightContainerX({bool isBottom = true}) {
    final x = (triggerBox.x +
        _half(triggerBox.w) -
        overlayBox.w +
        _half(arrowBox.w) +
        (overlayBox.w * 0.07));

    if (isBottom) {
      return x.floorToDouble();
    } else {
      return x.ceilToDouble();
    }
  }

  double _calculateCenterArrowX({bool isBottom = true}) {
    final x = (triggerBox.x + _half(triggerBox.w) - _half(arrowBox.w));
    if (isBottom) {
      return x.floorToDouble();
    } else {
      return x.ceilToDouble();
    }
  }

  double _calculateCenterContainerX({bool isBottom = true}) {
    final x = triggerBox.x + _half(triggerBox.w) - _half(overlayBox.w);
    if (isBottom) {
      return x.floorToDouble();
    } else {
      return x.ceilToDouble();
    }
  }

  /// Calculates y position for top and bottom positions
  ///   /// As y value increases from top to bottom of the device screen,
  /// for bottom floor the y value.
  /// else ceil the y value.
  double _calculateBottomArrowY() {
    final y = (triggerBox.y - distance - arrowBox.h);
    return y.floorToDouble();
  }

  double _calculateBottomContainerY() {
    final y = triggerBox.y - overlayBox.h - distance - arrowBox.h;
    return y.floorToDouble();
  }

  double _calculateTopArrowY() {
    final y = (triggerBox.y + triggerBox.h + distance);
    return y.ceilToDouble();
  }

  double _calculateTopContainerY() {
    final y = triggerBox.y + triggerBox.h + distance + arrowBox.h;
    return y.ceilToDouble();
  }

  /// checks if the container fits in the device screen
  bool _fitsScreen(ElementsDisplay el) {
    if (el.container.x > 0 &&
        el.container.x + el.container.w < screenSize.w &&
        el.container.y > 0 &&
        el.container.y + el.container.h < screenSize.h) {
      return true;
    }
    return false;
  }

  /// Tests each possible position until it finds one that fits.
  ElementsDisplay _firstAvailablePosition() {
    List<ElementsDisplay Function()> positions = [
      _topCenter,
      _bottomCenter,
      _topLeft,
      _topRight,
      _bottomLeft,
      _bottomRight,
    ];
    for (var position in positions) {
      if (_fitsScreen(position())) return position();
    }
    return _bottomCenter();
  }

  /// Load the calculated tooltip position
  ElementsDisplay load({ArrowPosition? preferredPosition}) {
    ElementsDisplay elementPosition;
      switch (preferredPosition) {
        case ArrowPosition.topLeft:
          elementPosition = _topLeft();
          break;
        case ArrowPosition.topCenter:
          elementPosition = _topCenter();
          break;
        case ArrowPosition.topRight:
          elementPosition = _topRight();
          break;
        case ArrowPosition.bottomLeft:
          elementPosition = _bottomLeft();
          break;
        case ArrowPosition.bottomCenter:
          elementPosition = _bottomCenter();
          break;
        case ArrowPosition.bottomRight:
          elementPosition = _bottomRight();
          break;
        default:
          elementPosition = _bottomCenter();
          break;
      }

    return _fitsScreen(elementPosition)
        ? elementPosition
        : _firstAvailablePosition();
  }
}
