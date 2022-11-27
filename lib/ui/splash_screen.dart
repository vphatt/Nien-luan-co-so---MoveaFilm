import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 8, 6, 29),
          Color.fromARGB(217, 35, 27, 110),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: const Center(
        child: Text('MoveaFilm'),
      ),
    ));
  }
}
