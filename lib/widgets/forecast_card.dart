import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/forecast_day.dart';

class ForecastCard extends StatelessWidget {
  final ForecastDay forecast;
  final double weeklyMin;
  final double weeklyMax;
  final double? currentTemp;

  const ForecastCard({
    super.key,
    required this.forecast,
    required this.weeklyMin,
    required this.weeklyMax,
    this.currentTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: .12),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: .10),
                  Colors.white.withValues(alpha: .05),
                ],
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.network(
                      forecast.iconUrl,
                      width: 34,
                      height: 34,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.cloud,
                          color: Colors.white,
                          size: 28,
                        );
                      },
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        currentTemp != null
                            ? "Today"
                            : DateFormat('EEEE').format(forecast.date),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Text(
                      forecast.condition,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    SizedBox(
                      width: 34,
                      child: Text(
                        "${forecast.minTemp.round()}°",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: SizedBox(
                        height: 18,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final trackWidth = constraints.maxWidth;

                            final start =
                                trackWidth * startPosition;

                            final end =
                                trackWidth * endPosition;

                            return Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                // Background Track
                                Center(
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: .08,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                  ),
                                ),

                                // Temperature Range
                                Positioned(
                                  left: start,
                                  child: Container(
                                    width: (end - start)
                                        .clamp(6.0, trackWidth),
                                    height: 6,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFF5EA6FF),
                                          Color(0xFF89D7FF),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Current Temperature Dot
                                if (currentPosition != null)
                                  Positioned(
                                    left: (trackWidth *
                                        currentPosition!)
                                        .clamp(
                                      6.0,
                                      trackWidth - 12,
                                    ) -
                                        6,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white70,
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                            Colors.white.withValues(
                                              alpha: .6,
                                            ),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    SizedBox(
                      width: 34,
                      child: Text(
                        "${forecast.maxTemp.round()}°",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double get startPosition {
    final range = weeklyMax - weeklyMin;

    if (range == 0) return 0;

    return ((forecast.minTemp - weeklyMin) / range)
        .clamp(0.0, 1.0);
  }

  double get endPosition {
    final range = weeklyMax - weeklyMin;

    if (range == 0) return 1;

    return ((forecast.maxTemp - weeklyMin) / range)
        .clamp(0.0, 1.0);
  }

  double? get currentPosition {
    if (currentTemp == null) return null;

    final range = weeklyMax - weeklyMin;

    if (range == 0) return 0.5;

    return ((currentTemp! - weeklyMin) / range)
        .clamp(0.0, 1.0);
  }
}