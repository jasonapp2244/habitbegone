import 'package:get/get.dart';
import 'package:habitsbegone/resources/routes/routes_name.dart';
import 'package:habitsbegone/view/auth_mannger_view.dart';
import 'package:habitsbegone/view/chose_plan_view.dart';
import 'package:habitsbegone/view/collective_program_view.dart';
import 'package:habitsbegone/view/cousre_view.dart';
import 'package:habitsbegone/view/elec_magnetic_view.dart';
import 'package:habitsbegone/view/home_view.dart';
import 'package:habitsbegone/view/hypnotherapy_view.dart';
import 'package:habitsbegone/view/login_view.dart';
import 'package:habitsbegone/view/massage_view.dart';
import 'package:habitsbegone/view/me_myself_Program_view.dart';
import 'package:habitsbegone/view/oboranding_view.dart';
import 'package:habitsbegone/view/onboarding_flow.dart';
import 'package:habitsbegone/view/one_on_one_view.dart';
import 'package:habitsbegone/view/osteopathy_view.dart';
import 'package:habitsbegone/view/sign_up_view.dart';
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
      name: RoutesName.authmanager,
      page: () => AuthManngerView(),
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
      name: RoutesName.signupview,
      page: () => SignUpView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.homeview,
      page: () => HomeView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.hypnotherapyview,
      page: () => HypnotherapyView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.massagetherapyview,
      page: () => MassageView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.elecmagnetictherapy,
      page: () => ElecMagneticView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.osteopathyview,
      page: () => OsteopathyView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.choseplanView,
      page: () => ChosePlanView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.memyselfprogram,
      page: () => MeMyselfProgramView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.oneonone,
      page: () => OneOnOneView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.collectiveProgram,
      page: () => CollectiveProgramView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RoutesName.mytakencousre,
      page: () => MyTakenCousreView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
  ];
}
