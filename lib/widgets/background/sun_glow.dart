import 'package:flutter/material.dart';

class SunGlow extends StatelessWidget {
  const SunGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: 150,
            right: 35,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFC107),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrangeAccent.withValues(alpha: .45),
                    blurRadius: 60,
                    spreadRadius: 18,
                  ),
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: .25),
                    blurRadius: 90,
                    spreadRadius: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}