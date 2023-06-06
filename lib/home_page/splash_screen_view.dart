import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class AnimatedProgressBar extends StatefulWidget {
  const AnimatedProgressBar({super.key});
  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      backgroundColor: Colors.grey,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
    );
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double barwidth = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/Logo.png',
              height: height * 0.5,
            ),
            SizedBox(
              width: barwidth,
              child: const AnimatedProgressBar(),
            ),
          ],
        ),
      ),
    );
  }
}