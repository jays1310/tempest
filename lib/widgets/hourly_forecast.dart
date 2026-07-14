import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/hourly_weather.dart';

class HourlyForecast extends StatelessWidget {
  final List<HourlyWeather> hourlyData;

  const HourlyForecast({
    super.key,
    required this.hourlyData,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
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
          child: SizedBox(
            height: 140,
            child: Stack(
              children: [
                Positioned(
                  top: 63,
                  left: 40,
                  right: 40,
                  child: Container(
                    height: 2,
                    color: Colors.white24,
                  ),
                ),
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hourlyData.length,
                  itemBuilder: (context, index) {
                    final hour = hourlyData[index];

                    return SizedBox(
                      width: 90,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? Colors.white.withValues(alpha: .18)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _formatTime(hour.time),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xFF24345E),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white24,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                hour.iconUrl,
                                width: 28,
                                height: 28,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.cloud,
                                    color: Colors.white,
                                    size: 22,
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            "${hour.temperature.round()}°",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();

    if (time.hour == now.hour &&
        time.day == now.day &&
        time.month == now.month) {
      return "NOW";
    }

    if (time.hour == 0) {
      return "12 AM";
    }

    if (time.hour < 12) {
      return "${time.hour} AM";
    }

    if (time.hour == 12) {
      return "12 PM";
    }

    return "${time.hour - 12} PM";
  }
}