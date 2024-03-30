import 'package:flutter/material.dart';
import 'package:smart_fridge/src/features/authentication/data/models/onboarding/onboarding_model.dart';

class OnboardingPageWidget extends StatefulWidget {
  const OnboardingPageWidget({
    super.key,
    required this.model,
  });

  final OnboardingModel model;

  @override
  State<OnboardingPageWidget> createState() => _OnboardingPageWidgetState();
}

class _OnboardingPageWidgetState extends State<OnboardingPageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 40000),
      vsync: this,
    );
    _topAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          weight: 0.5,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
          weight: 20,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
          weight: 0.5,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ),
          weight: 20,
        ),
      ],
    ).animate(_controller);
    _bottomAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
          weight: 0.5,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ),
          weight: 20,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          weight: 0.5,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
          weight: 20,
        ),
      ],
    ).animate(_controller);

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return _buildPage(size, context);
      },
    );
  }

  Container _buildPage(Size size, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: _topAlignmentAnimation.value,
          end: _bottomAlignmentAnimation.value,
          colors: widget.model.bgColors,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: AssetImage(widget.model.image),
              height: size.height * 0.4,
            ),
          ),
          Column(
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  widget.model.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text(
                  widget.model.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Text(
            widget.model.no == null ? '' : widget.model.no!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 80.0),
        ],
      ),
    );
  }
}
