import 'package:get/get.dart';
import 'package:habitsbegone/resources/routes/routes_name.dart';
import 'package:habitsbegone/view/home_view.dart';
import 'package:habitsbegone/view/login_view.dart';
import 'package:habitsbegone/view/oboranding_view.dart';
import 'package:habitsbegone/view/onboarding_flow.dart';
import 'package:habitsbegone/view/splash_view.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RoutesName.splashview,
      page: () => SplashView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.onboardingview,
      page: () => OborandingView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.onboardingflow,
      page: () => OnboardingFlow(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.loginview,
      page: () => LogiView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.homeview,
      page: () => HomeView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
  ];
}
