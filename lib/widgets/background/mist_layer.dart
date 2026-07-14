import 'dart:ui';

import 'package:flutter/material.dart';

class MistLayer extends StatefulWidget {
  const MistLayer({super.key});

  @override
  State<MistLayer> createState() => _MistLayerState();
}

class _MistLayerState extends State<MistLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 50),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              _mistBand(
                screenWidth: screenWidth,
                top: 110,
                width: screenWidth * 5.5,
                height: 70,
                opacity: .30,
                offset: .0,
              ),

              _mistBand(
                screenWidth: screenWidth,
                top: 170,
                width: screenWidth * 5.5,
                height: 70,
                opacity: .30,
                offset: .0,
              ),

              _mistBand(
                screenWidth: screenWidth,
                top: 260,
                width: screenWidth * 5.7,
                height: 85,
                opacity: .38,
                offset: .25,
              ),

              _mistBand(
                screenWidth: screenWidth,
                top: 350,
                width: screenWidth * 5.7,
                height: 85,
                opacity: .38,
                offset: .25,
              ),

              _mistBand(
                screenWidth: screenWidth,
                top: 430,
                width: screenWidth * 4.6,
                height: 75,
                opacity: .39,
                offset: .50,
              ),

              _mistBand(
                screenWidth: screenWidth,
                top: 510,
                width: screenWidth * 5.7,
                height: 85,
                opacity: .38,
                offset: .25,
              ),

              _mistBand(
                screenWidth: screenWidth,
                top: 620,
                width: screenWidth * 5.8,
                height: 90,
                opacity: .37,
                offset: .75,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _mistBand({
    required double screenWidth,
    required double top,
    required double width,
    required double height,
    required double opacity,
    required double offset,
  }) {
    final left =
        (((_controller.value + offset) % 1.0) * (screenWidth + width)) - width;

    return Positioned(
      top: top,
      left: left,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: 45,
          sigmaY: 45,
        ),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.transparent,
                Colors.white.withValues(alpha: opacity),
                Colors.white.withValues(alpha: opacity * 1.4),
                Colors.white.withValues(alpha: opacity),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}