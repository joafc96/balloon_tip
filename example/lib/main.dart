import 'package:balloon_tip/balloon_tip.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              BalloonTip(
                content: 'わたしは　にほんごがすこししか　はなせません。',
                arrowPosition: ArrowPosition.topLeft,
                child: Text("Top Left"),
              ),
              BalloonTip(
                content: 'わたしは　にほんごがすこししか　はなせません。',
                arrowPosition: ArrowPosition.topCenter,
                child: Text("Top Center"),
              ),
              BalloonTip(
                content: 'わたしは　にほんごがすこししか　はなせません。',
                arrowPosition: ArrowPosition.topRight,
                child: Text("Top Right"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              BalloonTip(
                content: 'わたしは　にほんごがすこししか　はなせません。',
                arrowPosition: ArrowPosition.bottomLeft,
                child: Text("Bottom Left"),
              ),
              BalloonTip(
                content: 'わたしは　にほんごがすこししか　はなせません。',
                arrowPosition: ArrowPosition.bottomCenter,
                child: Text("Bottom Center"),
              ),
              BalloonTip(
                content: 'わたしは　にほんごがすこししか　はなせません。',
                arrowPosition: ArrowPosition.bottomRight,
                child: Text("Bottom Right"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
