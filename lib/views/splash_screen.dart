import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:math' as math;

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, Widget? child) {
                return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi, child: child);
              },
              child: Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset("assets/images/covid_logo.png"),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .08,
              child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "   Covid-19\nTracker App",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
