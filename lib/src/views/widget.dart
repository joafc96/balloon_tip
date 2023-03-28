import 'package:balloon_tip/src/models/index.dart';
import 'package:balloon_tip/src/services/position.manager.dart';
import 'package:balloon_tip/src/utils/index.dart';
import 'package:balloon_tip/src/views/overlay/index.dart';
import 'package:flutter/widgets.dart';

class BalloonTip extends StatefulWidget {
  // @required
  /// [child] widget that will trigger the balloontip to appear.
  final Widget children;

  // @required
  /// [content] text that appears inside the balloontip.
  final String content;

  // @optional
  ///[top] top position for balloontip
  final double? top;

  // @optional
  ///[left] left position for balloontip
  final double? left;

  // @optional
  ///  Label for the button icon.
  final String? ariaLabel;

  // @optional
  /// [onClick] callback for balloonTip bubble close button.
  final VoidCallback? onClick;

  // @optional
  /// [arrowPosition] desired tooltip position in relationship to the trigger.
  /// The default value it bottomCenter.
  final ArrowPosition? arrowPosition;

  // @optional
  /// [distance] space between the balloonTip and the trigger.
  final double? distance;

// @optional
  /// [color] background color of the balloonTip and the arrow.
  final Color color;

  /// [timeout] number of seconds until the tooltip disappears automatically
  /// The default value is 0 (zero) which means it never disappears.
  final int? timeout;

  const BalloonTip({
    required this.children,
    required this.content,
    this.top,
    this.left,
    this.ariaLabel,
    this.onClick,
    this.arrowPosition = ArrowPosition.bottomCenter,
    this.color = Constants.fillBackGroundBalloonTipColor,
    this.distance = 0,
    this.timeout = 0,
    super.key,
  });

  @override
  State<BalloonTip> createState() => _BalloonTipState();
}

class _BalloonTipState extends State<BalloonTip> with WidgetsBindingObserver {
  final ElementBox _arrowBox = ElementBox.arrow();
  ElementBox _overlayBox = ElementBox.zero();
  final GlobalKey _widgetKey = GlobalKey();

  OverlayEntry? _overlayEntry;
  OverlayEntry? _overlayEntryHidden;

  ElementBox get _screenSize => _getScreenSize();
  ElementBox get _triggerBox => _getTriggerSize();
  ElementBox? get _userSpecifiedArrowStartPosition => _getUserSpecifiedSize();

  /// Init state and trigger the hidden overlay to measure its size
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _loadHiddenOverlay(context));
  }

  /// Dispose the observer
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Automatically hide the overlay when the screen dimension changes
  /// or when the user scrolls. This is done to avoid displacement.
  @override
  void didChangeMetrics() {
    _hideOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "balloon tip",
      container: true,
      explicitChildNodes: true,
      child: GestureDetector(
        onTap: () {
          if (_overlayEntry == null) {
            _showOverlay(context);
          }
        },
        child: widget.children,
      ),
    );
  }

  /// Measures the size of the trigger widget
  ElementBox _getTriggerSize() {
    if (mounted) {
      if (_userSpecifiedArrowStartPosition != null) {
        return _userSpecifiedArrowStartPosition!;
      }

      final renderBox = context.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      return ElementBox.rect(
        w: renderBox.size.width,
        h: renderBox.size.height,
        x: offset.dx,
        y: offset.dy,
      );
    }
    _hideOverlay();
    return ElementBox.zero();
  }

  /// Measures the size of the screen to calculate possible overflow
  ElementBox _getScreenSize() {
    return ElementBox.rect(
      w: MediaQuery.of(context).size.width,
      h: MediaQuery.of(context).size.height,
    );
  }

// Calculates the size if user has provided an external start position for the balloon tip
  ElementBox? _getUserSpecifiedSize() {
    if (widget.left != null && widget.top != null) {
      return ElementBox.point(
        x: widget.left!,
        y: widget.top!,
      );
    }
    return null;
  }

  /// Loads the tooltip into view
  void _showOverlay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);

    /// By calling [PositionManager.load()] we get returned the position
    /// of the tooltip, the arrow and the trigger.
    ElementsDisplay toolTipElementsDisplay = PositionManager(
      arrowBox: _arrowBox,
      overlayBox: _overlayBox,
      triggerBox: _triggerBox,
      screenSize: _screenSize,
      distance: widget.distance!,
    ).load(
      preferredPosition: widget.arrowPosition,
    );

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // overlay key
            Positioned(
              top: toolTipElementsDisplay.arrow.y,
              left: toolTipElementsDisplay.arrow.x,
              child: OverlayArrow(
                color: widget.color,
                position: toolTipElementsDisplay.arrowPosition,
                width: _arrowBox.w,
                height: _arrowBox.h,
              ),
            ),

            // overlay container
            Positioned(
              top: toolTipElementsDisplay.container.y,
              left: toolTipElementsDisplay.container.x,
              child: OverlayContainer(
                key: _widgetKey,
                color: widget.color,
                onBackPressed: _hideOverlay,
                child: widget.content,
              ),
            ),
          ],
        );
      },
    );

    if (_overlayEntry != null) {
      overlayState.insert(_overlayEntry!);
    }

    // Add timeout for the tooltip to disapear after a few seconds
    if (widget.timeout! > 0) {
      await Future.delayed(Duration(seconds: widget.timeout!))
          .whenComplete(() => _hideOverlay());
    }
  }

  /// Method to hide the tooltip
  void _hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  /// Loads the tooltip container without opacity to measure the rendered size.
  void _loadHiddenOverlay(_) {
    OverlayState? overlayStateHidden = Overlay.of(context);
    _overlayEntryHidden = OverlayEntry(
      builder: (context) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => _getHiddenOverlaySize(context));
        return Opacity(
          opacity: 0,
          child: Center(
            child: OverlayContainer(
              key: _widgetKey,
              color: widget.color,
              child: widget.content,
            ),
          ),
        );
      },
    );

    if (_overlayEntryHidden != null) {
      overlayStateHidden.insert(_overlayEntryHidden!);
    }
  }

  /// Measures the size of the hidden tooltip container after it's loaded with _loadHiddenOverlay(_)
  void _getHiddenOverlaySize(context) {
    RenderBox box = _widgetKey.currentContext?.findRenderObject() as RenderBox;
    if (mounted) {
      setState(() {
        _overlayBox = ElementBox.rect(
          w: box.size.width,
          h: box.size.height,
        );
        _overlayEntryHidden?.remove();
      });

      /// if balloon tip has to be initialised during load, please add it here.
      // if (_overlayEntry == null) {
      // _showOverlay(context);
      // }
    }
  }
}
