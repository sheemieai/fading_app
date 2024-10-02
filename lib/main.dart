import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  final Random random = Random();
  int randomImgNumber = 0;
  int lastImgNumber = 0;
  int loadingImgNumber = 0;
  double numberOfTurns = 0.0;
  final String loadingSquareImg = "lib/img/square.png";
  final List<Color> loadingColorList = [Colors.green, Colors.red];
  final List<String> ghostImgList = [
    "lib/img/ghost-cool.png", "lib/img/ghost-dap.png", "lib/img/ghost-go.png",
    "lib/img/ghost-mad.png", "lib/img/ghost-peace.png", "lib/img/ghost-thumbs.png"
  ];
  final List<String> ghostEmotionString = [
    "I am so cool!", "I am dapping, yo!", "Let's Go!!",
    "I am so mad, GRRRR!!", "Peace out Homie!!", "Great Job!!"
  ];


  void toggleVisibility() {
    setState(() {
      loadingImgNumber = loadingImgNumber == 0 ? 1 : 0;

      if (!_isVisible) {
        getRandomNumber();
      }

      _isVisible = !_isVisible;
      rotateTheImg();
      lastImgNumber = randomImgNumber;
    });
  }

  void getRandomNumber() {
    setState(() {
      while (randomImgNumber == lastImgNumber) {
        randomImgNumber = random.nextInt(6);
      }
    });
  }

  void rotateTheImg() {
    setState(() {
      numberOfTurns++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fading Text Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Text(
                ghostEmotionString[randomImgNumber],
                style: TextStyle(fontSize: 24),
              ),
            ),
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                ghostImgList[randomImgNumber],
              )
            ),
            AnimatedRotation(
              turns: numberOfTurns,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                loadingSquareImg,
                width: 40.0,
                height: 40.0,
                color: loadingColorList[loadingImgNumber],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
