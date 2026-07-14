import 'dart:math';

import 'package:flutter/material.dart';

class NightSkyLayer extends StatefulWidget {
  const NightSkyLayer({super.key});

  @override
  State<NightSkyLayer> createState() => _NightSkyLayerState();
}

class _NightSkyLayerState extends State<NightSkyLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  final Random random = Random(10);

  late final List<_Star> stars;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    stars = List.generate(
      70,
          (index) => _Star(
        random.nextDouble(),
        random.nextDouble(),
        1 + random.nextDouble() * 2.5,
        random.nextDouble() * 2 * pi,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: [
              // Crescent Moon
              Positioned(
                top: 150,
                right: 35,
                child: Transform.rotate(
                  angle: -0.3,
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: ClipOval(
                      child: Stack(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFBF00),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withValues(alpha: .35),
                                  blurRadius: 55,
                                  spreadRadius: 15,
                                ),
                              ],
                            ),
                          ),

                          Positioned(
                            left: -3,
                            top: -15,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                color: Color(0xFF0B1020),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Stars
              ...stars.map((star) {
                final opacity =
                    0.25 +
                        ((sin(
                          controller.value * 2 * pi +
                              star.phase,
                        ) +
                            1) /
                            2) *
                            0.75;

                return Positioned(
                  left: star.x * width,
                  top: star.y * 320,
                  child: Container(
                    width: star.size,
                    height: star.size,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: opacity),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

class _Star {
  final double x;
  final double y;
  final double size;
  final double phase;

  _Star(
      this.x,
      this.y,
      this.size,
      this.phase,
      );
}