import 'dart:ui';
import 'package:flutter/material.dart';

class HourlyCard extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;
  final bool isNow;

  const HourlyCard({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
    this.isNow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      margin: const EdgeInsets.only(right: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 18,
            sigmaY: 18,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: .12),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: .12),
                  Colors.white.withValues(alpha: .05),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  isNow ? "NOW" : time,
                  style: TextStyle(
                    color: isNow
                        ? Colors.white
                        : Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),

                Icon(
                  icon,
                  color: Colors.amber,
                  size: 28,
                ),

                Text(
                  temperature,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                Container(
                  width: 30,
                  height: 1,
                  color: Colors.white24,
                ),

                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}