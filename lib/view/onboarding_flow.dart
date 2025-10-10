import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/resources/routes/routes_name.dart';
import 'package:habitsbegone/view/auth/oboranding_view.dart';
import 'package:habitsbegone/view/onborading_view2.dart';
import 'package:habitsbegone/view/onborading_view3.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _nextPage();
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _startTimer();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Stop timer and navigate to login after last onboarding screen
      _timer?.cancel();
      Get.toNamed(RoutesName.loginview);
    }
  }

  void _skipToLogin() {
    _timer?.cancel();
    Get.toNamed(RoutesName.loginview);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            _resetTimer(); // Reset timer when user taps
            _nextPage();
          },
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [OborandingView(), OborandingView2(), OnboradingView3()],
          ),
        ),
      ),
    );
  }
}
