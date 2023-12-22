import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/features/weather/presentation/weather_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyleWithShadow = TextStyle(color: Colors.white, shadows: [
      BoxShadow(
        color: Colors.black12.withOpacity(0.25),
        spreadRadius: 0.5,
        blurRadius: 4,
        offset: const Offset(0, 0.5),
      )
    ]);
    return MaterialApp(
      title: 'WEATHER MADness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          displayLarge: textStyleWithShadow,
          displayMedium: textStyleWithShadow,
          displaySmall: textStyleWithShadow,
          headlineMedium: textStyleWithShadow,
          headlineSmall: textStyleWithShadow,
          titleMedium: const TextStyle(color: Colors.white),
          bodyMedium: const TextStyle(color: Colors.white),
          bodyLarge: const TextStyle(color: Colors.white),
          bodySmall: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Create a Tween that varies from 0 to 1 for fading in the text
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    Timer(
      Duration(seconds: 1),
          () {
        // Start the bouncy animation after 1 second
        _controller.forward();
      },
    );

    Timer(
      Duration(seconds: 4),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WeatherPage(city: 'colombo')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFF8200B0)], // Black to Blue gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BouncyBuilder(
                animation: _controller,
                child: Image.asset(
                  'assets/weather 2.png',
                  width: 300,
                  height: 300,
                ),
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(00 * _animation.value, 0),
                    child: Opacity(
                      opacity: _animation.value,
                      child: Image.asset(
                        'assets/Weather.png',
                        width: 300,
                        height: 300,
                      ),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(20 * _animation.value, -100),
                    child: Opacity(
                      opacity: _animation.value,
                      child: Image.asset(
                        'assets/MADness.png',
                        width: 300,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1),
                duration: const Duration(milliseconds: 2500),
                builder: (context, value, _) {
                  // Choose your desired color here
                  Color progressColor = Colors.blue;

                  return CircularProgressIndicator(
                    value: value,
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BouncyBuilder extends StatelessWidget {
  final AnimationController animation;
  final Widget child;

  const BouncyBuilder({
    Key? key,
    required this.animation,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // Adjust the stopping point by subtracting a value from the original offset
        double adjustedOffset = 100 * Curves.bounceOut.transform(animation.value) - 100;

        return Transform.translate(
          offset: Offset(
            adjustedOffset,
            0,
          ),
          child: Opacity(
            opacity: Curves.bounceOut.transform(animation.value),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

