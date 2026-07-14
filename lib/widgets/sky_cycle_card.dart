import 'dart:ui';

import 'package:flutter/material.dart';

class SkyCycleCard extends StatelessWidget {
  final String sunrise;
  final String sunset;

  final String moonrise;
  final String moonset;

  final DateTime localTime;

  const SkyCycleCard({
    super.key,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.localTime,
  });

  @override
  Widget build(BuildContext context) {
    final isNight = _isNight();

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 18,
          sigmaY: 18,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: .15),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: .14),
                Colors.white.withValues(alpha: .08),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sky Cycle",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                isNight ? "Night" : "Daytime",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 22),

              _buildCycleRow(
                start: sunrise,
                end: sunset,
                progress: _calculateProgress(
                  start: sunrise,
                  end: sunset,
                ),
                startIcon: Icons.wb_twilight,
                endIcon: Icons.dark_mode_rounded,
                movingIcon: Icons.wb_sunny_rounded,
                glowColor: const Color(0xFFFFC107),
                iconColor: const Color(0xFFFFC107),
              ),

              const SizedBox(height: 20),

              _buildCycleRow(
                start: moonrise,
                end: moonset,
                progress: _calculateProgress(
                  start: moonrise,
                  end: moonset,
                ),
                startIcon: Icons.nightlight_round,
                endIcon: Icons.nightlight_round,
                movingIcon: Icons.dark_mode,
                glowColor: Colors.white,
                iconColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCycleRow({
    required String start,
    required String end,
    required double progress,
    required IconData startIcon,
    required IconData endIcon,
    required IconData movingIcon,
    required Color glowColor,
    required Color iconColor,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 34,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    left: 0,
                    child: Icon(
                      startIcon,
                      color: iconColor,
                      size: 24,
                    ),
                  ),

                  Positioned(
                    right: 0,
                    child: Icon(
                      endIcon,
                      color: iconColor,
                      size: 24,
                    ),
                  ),

                  Positioned(
                    left: 18,
                    right: 18,
                    top: 15,
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 18 + (width - 36) * progress - 12,
                    top: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: glowColor.withValues(alpha: .45),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        movingIcon,
                        color: iconColor,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: Text(
                start,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
            ),

            Expanded(
              child: Text(
                end,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool _isNight() {
    final now = localTime;

    final sunriseTime = _parseTime(sunrise);
    final sunsetTime = _parseTime(sunset);

    return now.isBefore(sunriseTime) || now.isAfter(sunsetTime);
  }

  double _calculateProgress({
    required String start,
    required String end,
  }) {
    try {
      final startTime = _parseTime(start);
      final endTime = _parseTime(end);

      final now = localTime;

      final current = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
      );

      if (current.isBefore(startTime)) {
        return 0;
      }

      if (current.isAfter(endTime)) {
        return 1;
      }

      final total = endTime.difference(startTime).inMinutes;
      final passed = current.difference(startTime).inMinutes;

      return (passed / total).clamp(0.0, 1.0);
    } catch (_) {
      return .5;
    }
  }

  DateTime _parseTime(String value) {
    final now = localTime;

    final parts = value.split(" ");

    final hm = parts[0].split(":");

    int hour = int.parse(hm[0]);
    final minute = int.parse(hm[1]);

    final period = parts[1];

    if (period == "PM" && hour != 12) {
      hour += 12;
    }

    if (period == "AM" && hour == 12) {
      hour = 0;
    }

    return DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
  }
}