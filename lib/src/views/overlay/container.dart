import 'package:balloon_tip/src/utils/index.dart';
import 'package:flutter/widgets.dart';


/// Bubble serves as the tooltip container
class OverlayContainer extends StatelessWidget {
  /// [color] background color applied to the container
  final Color color;

  /// [padding] edgeinsets applied to the child
  final EdgeInsets padding;

  /// [maxWidth] maximum width applied to the container 
  /// deafault value is 200
  final double maxWidth;

  /// [onBackPressed] function which triggers while user clicks the close icon
  final VoidCallback? onBackPressed;

  /// [child] child of the container
  final String child;

  const OverlayContainer({
    required this.child,
    required this.color,
    this.onBackPressed,
    this.padding = Constants.overlayContainerPadding,
    this.maxWidth = Constants.overlayContainerMaxWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: padding,
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Expanded(
            //   child: UQCaption(
            //     color: CaptionColorType.primaryLight,
            //     variant: CaptionVariant.standard,
            //     children: child,
            //   ),
            // ),
            // GestureDetector(
            //   onTap: onBackPressed,
            //   child: Container(
            //     height: BalloonTipConstants.iconContainerWidth,
            //     width: BalloonTipConstants.iconContainerWidth,
            //     alignment: Alignment.center,
            //     child: UQIcon(
            //       name: "close",
            //       color: FillColor.fillSecondaryColor,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
