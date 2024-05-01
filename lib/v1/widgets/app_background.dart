import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [0.0, 0.5, 0.9],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF69B4FF), // Modern Blue
            Color(0xFFD3C8F6), // Modern Lavender
            Color(0xFFFFB6B9), // Modern Pink/ Light
          ],
        ),
      ),
    );
  }
}
