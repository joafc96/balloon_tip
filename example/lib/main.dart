import 'dart:developer';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {


    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    const balloonTipContent = Text(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum vel mauris velit.",
      style: TextStyle(
        fontSize: 14,
        height: 1.5,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );

    return Scaffold(
      body: Center(
        child: BalloonTip(
          arrowPosition: ArrowPosition.bottomCenter,
          containerMaxWidth: 200,
          arrowTipDistance: 0,
          content: balloonTipContent,
          onDismiss: () {
            log("on back pressed");
          },
          child: FloatingActionButton.small(
            onPressed: () {},
            backgroundColor: Colors.pinkAccent,
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
