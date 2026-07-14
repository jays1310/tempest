import 'dart:math';

import 'package:flutter/material.dart';

class SnowLayer extends StatefulWidget {
  const SnowLayer({super.key});

  @override
  State<SnowLayer> createState() => _SnowLayerState();
}

class _SnowLayerState extends State<SnowLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return CustomPaint(
            size: MediaQuery.of(context).size,
            painter: SnowPainter(controller.value),
          );
        },
      ),
    );
  }
}

class SnowPainter extends CustomPainter {
  final double progress;

  SnowPainter(this.progress);

  final Random random = Random(42);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: .9);

    for (int i = 0; i < 140; i++) {
      final radius = 1.5 + random.nextDouble() * 3;

      final baseX = random.nextDouble() * size.width;

      final sway =
          sin((progress * 2 * pi) + i) * 18;

      final x = baseX + sway;

      final y =
          ((random.nextDouble() + progress) % 1.0) *
              (size.height + 40) -
              40;

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant SnowPainter oldDelegate) {
    return true;
  }
}