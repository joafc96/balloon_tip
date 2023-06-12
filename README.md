# balloon_tip

`balloon_tip` gives you more flexibility over the Flutter standard `Tooltip` by allowing you to set arbitrary content. It also expands on their single axis layout algorithm to fit both vertically and horizontally. The tooltip can be positioned along any axis and importantly can be used inside scroll views.

## Getting Started

###  Depend on it
Add this to your package's `pubspec.yaml` file:
```yaml
dependencies:
  balloon_tip: <latest version>
```

### Import it
Now in your `Dart` code, you can use:
```dart
import 'package:balloon_tip/balloon_tip.dart';
```

To add the UI is as simple as: 
```dart
BalloonTip(
      arrowPosition: ArrowPosition.bottomCenter,
      containerMaxWidth: 200,
      arrowTipDistance: 0,
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

API subject to change.

## Contributing

Issues and PRs welcome. Unless otherwise specified, all contributions to this lib will be under MIT license.

## Help wanted

If you're interested in becoming a contributor with push rights please ping me and we can talk about how to get you started ! :)