import 'dart:ui';

import 'package:flutter/material.dart';

class CloudLayer extends StatefulWidget {
  const CloudLayer({super.key});

  @override
  State<CloudLayer> createState() => _CloudLayerState();
}

class _CloudLayerState extends State<CloudLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 80),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              _cloud(
                top: 70,
                width: 240,
                height: 90,
                progress: _controller.value,
                speed: 0.15,
                opacity: 0.08,
              ),

              _cloud(
                top: 180,
                width: 300,
                height: 110,
                progress: _controller.value,
                speed: 0.30,
                opacity: 0.10,
              ),

              _cloud(
                top: 320,
                width: 210,
                height: 80,
                progress: _controller.value,
                speed: 0.45,
                opacity: 0.07,
              ),

              _cloud(
                top: 470,
                width: 260,
                height: 95,
                progress: _controller.value,
                speed: 0.60,
                opacity: 0.09,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _cloud({
    required double top,
    required double width,
    required double height,
    required double progress,
    required double speed,
    required double opacity,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    final left =
        ((progress + speed) % 1.0) * (screenWidth + width) - width;

    return Positioned(
      top: top,
      left: left,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            Positioned(
              left: width * 0.10,
              top: height * 0.20,
              child: _blob(
                width * 0.45,
                height * 0.55,
                opacity,
              ),
            ),

            Positioned(
              left: width * 0.30,
              top: 0,
              child: _blob(
                width * 0.38,
                height * 0.60,
                opacity,
              ),
            ),

            Positioned(
              left: width * 0.52,
              top: height * 0.18,
              child: _blob(
                width * 0.42,
                height * 0.55,
                opacity,
              ),
            ),

            Positioned(
              left: width * 0.18,
              top: height * 0.35,
              child: _blob(
                width * 0.62,
                height * 0.42,
                opacity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _blob(
      double width,
      double height,
      double opacity,
      ) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: 20,
        sigmaY: 20,
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: opacity),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}