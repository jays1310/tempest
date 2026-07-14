import 'dart:math';
import 'package:flutter/material.dart';

class RainLayer extends StatefulWidget {
  const RainLayer({super.key});

  @override
  State<RainLayer> createState() => _RainLayerState();
}

class _RainLayerState extends State<RainLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
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
            painter: RainPainter(controller.value),
          );
        },
      ),
    );
  }
}

class RainPainter extends CustomPainter {
  final double progress;

  RainPainter(this.progress);

  final Random random = Random(7);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: .28)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 180; i++) {
      final x = random.nextDouble() * size.width;

      final y =
          ((random.nextDouble() + progress) % 1.0) *
              (size.height + 60) -
              60;

      canvas.drawLine(
        Offset(x, y),
        Offset(x - 7, y + 18),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant RainPainter oldDelegate) {
    return true;
  }
}