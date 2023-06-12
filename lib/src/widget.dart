import 'package:flutter/widgets.dart';

import 'models/index.dart';
import 'overlay/index.dart';
import 'position/index.dart';
import 'types.dart';

class BalloonTip extends StatefulWidget {
  // @required
  /// [child] Widget that will trigger the balloontip to appear.
  final Widget child;

  // @required
  /// [content] Content within the balloontip bubble.
  final Widget content;

  // @optional
  /// [onClick] Callback for balloonTip bubble close button.
  final VoidCallback? onClick;

  // @optional
  // default: `BalloonTipArrowPosition.bottomCenter`
  /// [arrowPosition] Desired tooltip position in relationship to the trigger.
  final ArrowPosition? arrowPosition;

  /* BELOW PROPS ARE NOT PROVIDED IN FIGMA */
  // @optional
  /// [distance] Space between the balloonTip and the trigger.
  final double? distance;

  // @optional
  /// [color] Background color of the balloonTip and the arrow.
  final Color? color;

  // @optional
  /// [semanticsLabel] An optional semanticsLabel to be provided for automation team
  final String? semanticsLabel;

  const BalloonTip({
    required this.child,
    required this.content,
    this.onClick,
    this.color,
    this.arrowPosition = ArrowPosition.bottomCenter,
    this.distance = 0,
    this.semanticsLabel,
    super.key,
  });

  @override
  State<BalloonTip> createState() => _BalloonTipState();
}

class _BalloonTipState extends State<BalloonTip>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
    reverseDuration: const Duration(milliseconds: 75),
    debugLabel: "__balloon_tip_animation__",
    value: 0.0,
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late final Animation<double> _fadeAnim = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOut,
    reverseCurve: Curves.easeInOut,
  );

  // Unique link used for composited target and follower
  final _layerLink = LayerLink();

  // Boxes that holds the size, position of arrow , overlay and trigger
  final ElementBox _arrowBox = ElementBox.arrow();
  ElementBox _overlayBox = ElementBox.zero();
  ElementBox get _triggerBox => _getTriggerSize();

  // Keys for measuring the size and position of the boxes
  final GlobalKey _hiddenOverlayKey =
      GlobalKey(debugLabel: "__hidden_overlay__");
  final GlobalKey _triggerBoxKey = GlobalKey(debugLabel: "__trigger_box__");

  // Overlay state and entries
  late final OverlayState? _overlayState = Overlay.of(context);
  OverlayEntry? _overlayContainerEntry;
  OverlayEntry? _overlayArrowEntry;

  // hidden overlay used to measure overlay box size
  OverlayEntry? _overlayEntryHidden;

  /// [return] animationController of check status and animation
  AnimationController? get animationController => _animationController;

  // Bool to check whether the overlay is shown or not
  bool _overlayIsShown = false;

  /// Trigger the hidden overlay to measure its size
  @override
  void initState() {
    super.initState();

    // Involves setState so we do it in a post frame callback
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadHiddenOverlay(context);
      }
    });
  }

  /// Dispose the observer
  @override
  void dispose() {
    animationController?.dispose();

    // Involves setState so we do it in a post frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hideOverlay();
    });
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        key: _triggerBoxKey,
        child: widget.child,
      ),
    );
  }

  /// Loads the balloontip container without opacity to measure the rendered size.
  void _loadHiddenOverlay(_) {
    _overlayEntryHidden = OverlayEntry(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _getHiddenOverlaySize(context),
        );

        return Opacity(
          opacity: 0,
          child: Center(
            child: OverlayContainer(
              key: _hiddenOverlayKey,
              color: widget.color,
              fadeAnimation: _fadeAnim,
              child: widget.content,
            ),
          ),
        );
      },
    );

    _overlayState?.insert(_overlayEntryHidden!);
  }

  /// Loads the balloontip into view
  void _showOverlay(BuildContext context) async {
    if (_overlayIsShown || !mounted) {
      return;
    }

    /// By calling [PositionManager.load()] we get returned the position
    /// of the tooltip, the arrow and the trigger.
    BalloonTipElementsDisplay toolTipElementsDisplay = PositionManager(
      params: PositionStrategyParams(
        arrowBox: _arrowBox,
        triggerBox: _triggerBox,
        overlayBox: _overlayBox,
        distance: widget.distance!,
      ),
    ).load(
      preferredPosition: widget.arrowPosition,
    );

    // ARROW ENTRY
    _overlayArrowEntry = OverlayEntry(
      builder: (context) {
        return Align(
          alignment: Alignment.topLeft,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(
              toolTipElementsDisplay.arrow.x,
              toolTipElementsDisplay.arrow.y,
            ),
            showWhenUnlinked:
                false, // to hide the follower when unlinked from the target
            child: OverlayArrow(
              color: widget.color,
              position: toolTipElementsDisplay.position,
              width: _arrowBox.w,
              height: _arrowBox.h,
              fadeAnimation: _fadeAnim,
              semanticsLabel: widget.semanticsLabel,
            ),
          ),
        );
      },
    );

    // CONTAINER ENTRY
    _overlayContainerEntry = OverlayEntry(
      builder: (context) {
        return Align(
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(
              toolTipElementsDisplay.container.x,
              toolTipElementsDisplay.container.y,
            ),
            showWhenUnlinked:
                false, // to hide the follower when unlinked from the target
            child: OverlayContainer(
              color: widget.color,
              onBackPressed: _onBackPressed,
              fadeAnimation: _fadeAnim,
              semanticsLabel: widget.semanticsLabel,
              child: widget.content,

            ),
          ),
        );
      },
    );

    _overlayState?.insert(_overlayContainerEntry!);
    _overlayState?.insert(_overlayArrowEntry!);

    _overlayIsShown = true;
  }

  /// Method to hide the tooltip
  void _hideOverlay() {
    if (!_overlayIsShown) {
      return;
    }

    // removes the arrow overlay entry
    _overlayArrowEntry?.remove();
    _overlayArrowEntry = null;

    // removes the container overlay entry
    _overlayContainerEntry?.remove();
    _overlayContainerEntry = null;

    _overlayIsShown = false;
  }

  /// Measures the size of the trigger widget
  ElementBox _getTriggerSize() {
    if (mounted) {
      final RenderBox? box =
          _triggerBoxKey.currentContext?.findRenderObject() as RenderBox?;

      if (box == null) {
        throw StateError(
          'Cannot find the box for key $_triggerBox of the given object with context $context',
        );
      }

      return ElementBox.rect(
        w: box.size.width,
        h: box.size.height,
      );
    }

    return ElementBox.zero();
  }

  /// Measures the size of the hidden tooltip container after it's loaded with _loadHiddenOverlay(_)
  void _getHiddenOverlaySize(context) async {
    final RenderBox? box =
        _hiddenOverlayKey.currentContext?.findRenderObject() as RenderBox?;

    if (box == null) {
      throw StateError(
        'Cannot find the box for key $_hiddenOverlayKey of the given object with context $context',
      );
    }

    _overlayBox = ElementBox.rect(
      w: box.size.width,
      h: box.size.height,
    );
    _overlayEntryHidden?.remove();

    // show overlay after removing hidden overlay
    _showOverlay(context);
    await _animationController.forward();
  }

  // Handles the back press event
  void _onBackPressed() async {
    widget.onClick?.call();

    await _animationController.reverse();
    _hideOverlay();
  }
}
