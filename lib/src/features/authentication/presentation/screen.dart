import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_fridge/src/features/authentication/presentation/register/pages/screen.dart';

import 'login/pages/screen.dart';

class AppAuthScreen extends StatefulWidget {
  final bool isLogin;

  const AppAuthScreen({
    super.key,
    required this.isLogin,
  });

  @override
  State<AppAuthScreen> createState() => _AppAuthScreenState();
}

class _AppAuthScreenState extends State<AppAuthScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  double _currentPageIndex = 0.0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: widget.isLogin ? 0 : 1,
    )..addListener(() {
        setState(() {
          _currentPageIndex = _pageController.page ?? 0;
        });
      });
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 60.0, end: 100.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    AppLoginScreen(
                      pageController: _pageController,
                      animation: _animation,
                    ),
                    AppRegisterScreen(
                      pageController: _pageController,
                      animation: _animation,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top - 36,
            right: 10.0 + _currentPageIndex * 340.0,
            child: SafeArea(
              child: IconButton(
                icon: Icon(
                  Iconsax.arrow_swap_horizontal_copy,
                  size: 24.0,
                  color: Colors.black.withOpacity(0.4),
                ),
                onPressed: _togglePage,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _togglePage() {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        _pageController.page!.toInt() == 0 ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
