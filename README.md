# balloon_tip

`balloon_tip` gives you more flexibility over the Flutter standard `Tooltip` by allowing you to set arbitrary content. It also expands on their single axis layout algorithm to fit both vertically and horizontally. The tooltip can be positioned along any axis and importantly can be used inside scroll views.

<div style="display: flex;">
<img src="https://github.com/joafc96/balloon_tip/raw/main/assets/bottom_center_balloon_tip.png" width="300">
<img src="https://github.com/joafc96/balloon_tip/blob/main/assets/balloon_tip_scroll_view_example.gif" width="300">
</div>

## Features
* Easy creation of multi directional overlay tooltips
* Algorithm automatically calculates where the tool tip has to be positioned wrt child provided
* Opportunity to hide the tooltip programmatically
* The tooltip works in lists and follow the target through scrolling (LFG)
* No external dependencies

## Getting Started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  balloon_tip:  ^0.0.1
```

Now in your `Dart` code, you can use:
```dart
import 'package:balloon_tip/balloon_tip.dart';
```

To add the UI is as simple as: 
```dart
BalloonTip(
      arrowPosition: ArrowPosition.bottomCenter,
      content: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel mauris velit. Maecenas convallis sapien non pharetra viverra. Maecenas tristique purus at aliquam convallis. Nam vestibulum ipsum sem. In scelerisque massa at iaculis tempor.",
                  style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
      child: FloatingActionButton.small(
        onPressed: () {},
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.favorite),
  ),
),
```

## Contributing

Issues and PRs welcome. Unless otherwise specified, all contributions to this lib will be under MIT license.
