import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class LightningLayer extends StatefulWidget {
  const LightningLayer({super.key});

  @override
  State<LightningLayer> createState() => _LightningLayerState();
}

class _LightningLayerState extends State<LightningLayer> {
  final Random _random = Random();

  double _opacity = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scheduleFlash();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _scheduleFlash() {
    final seconds = 3 + _random.nextInt(6);

    _timer = Timer(Duration(seconds: seconds), () async {
      await _flash();

      if (mounted) {
        _scheduleFlash();
      }
    });
  }

  Future<void> _flash() async {
    setState(() => _opacity = 0.55);
    await Future.delayed(const Duration(milliseconds: 70));

    setState(() => _opacity = 0.10);
    await Future.delayed(const Duration(milliseconds: 50));

    setState(() => _opacity = 0.75);
    await Future.delayed(const Duration(milliseconds: 80));

    setState(() => _opacity = 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 120),
        opacity: _opacity,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color(0xCCFFFFFF),
                Color(0x88FFFFFF),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}