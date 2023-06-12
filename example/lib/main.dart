import 'package:balloon_tip/balloon_tip.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Balloon Tip Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const balloonTipContent = Text(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla porta aliquam metus a tincidunt. Ut ac suscipit magna.",
      style: TextStyle(
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                BalloonTip(
                  content: balloonTipContent,
                  arrowPosition: ArrowPosition.bottomLeft,
                  child: Text("Bottom Left"),
                ),
                BalloonTip(
                  content: balloonTipContent,
                  arrowPosition: ArrowPosition.topCenter,
                  containerMaxWidth: 250,
                  child: Text("Top Center"),
                ),
                BalloonTip(
                  content: balloonTipContent,
                  arrowPosition: ArrowPosition.bottomRight,
                  child: Text("Bottom Right"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                BalloonTip(
                  content: balloonTipContent,
                  arrowPosition: ArrowPosition.topLeft,
                  child: Text("Top Left"),
                ),
                BalloonTip(
                  content: balloonTipContent,
                  arrowPosition: ArrowPosition.bottomCenter,
                  containerMaxWidth: 250,
                  child: Text("Bottom Center"),
                ),
                BalloonTip(
                  content: balloonTipContent,
                  arrowPosition: ArrowPosition.topRight,
                  child: Text("Top Right"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
