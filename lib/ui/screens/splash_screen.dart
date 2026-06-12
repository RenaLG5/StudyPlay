import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print("SPLASH");
    Timer(const Duration(seconds: 5), () {
      print("IR MENU");
      Navigator.pushReplacementNamed(context, '/menu');
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            Image.asset('assets/images/perrito1.png', width: 120),

            const SizedBox(height: 20),

            const Text(
              'StudyPlay',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const Spacer(),

            const Text(
              '100% Gratis - Sin Publicidad',
              style: TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
