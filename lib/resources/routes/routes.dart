import 'package:get/get.dart';
import 'package:getxmvvm/resources/routes/routes_name.dart';
import 'package:getxmvvm/view/home_view.dart';
import 'package:getxmvvm/view/login_view.dart';
import 'package:getxmvvm/view/splash_view.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RoutesName.splashview,
      page: () => SplashView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ), GetPage(
      name: RoutesName.loginview,
      page: () => LoginView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ), GetPage(
      name: RoutesName.homeview,
      page: () => HomeView(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.leftToRight,
    ),
  ];
}
