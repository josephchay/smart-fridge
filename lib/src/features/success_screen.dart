import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_fridge/src/features/result_screen.dart';

class AppSuccessToastScreen extends StatefulWidget {
  const AppSuccessToastScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String image;
  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  @override
  State<AppSuccessToastScreen> createState() => _AppSuccessToastScreenState();
}

class _AppSuccessToastScreenState extends State<AppSuccessToastScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationBottom;
  late Animation<double> _animationTop;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _animationTop = Tween<double>(begin: 60.0, end: 100.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _animationBottom = Tween<double>(begin: 120.0, end: 150.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: 160,
            left: 80,
            top: 70,
            child: Image.asset(
              'assets/images/miscellaneous/green-blue-gradient-blob.png',
            ),
          ),
          AnimatedBuilder(
            animation: _animationTop,
            builder: (BuildContext context, Widget? child) {
              return Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _animationTop.value,
                    sigmaY: _animationTop.value,
                  ),
                  child: const SizedBox(),
                ),
              );
            },
          ),
          Positioned(
            width: 300,
            right: -60,
            bottom: -70,
            child: Image.asset(
              'assets/images/miscellaneous/yellow-orange-gradient-blob.png',
            ),
          ),
          AnimatedBuilder(
            animation: _animationBottom,
            builder: (BuildContext context, Widget? child) {
              return Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _animationBottom.value,
                    sigmaY: _animationBottom.value,
                  ),
                  child: const SizedBox(),
                ),
              );
            },
          ),
          AppResultScreen(
            image: widget.image,
            title: widget.title,
            subTitle: widget.subTitle,
            onPressed: widget.onPressed,
          ),
        ],
      ),
    );
  }
}
