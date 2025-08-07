import 'dart:async';
import 'package:getxmvvm/viewmodel/controller/login/user_prefrence/users_prefrence.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:getxmvvm/resources/routes/routes_name.dart';

class SplashServices {
  UsersPrefrence usersPrefrence = UsersPrefrence();
  
  void checkAppState() async {
    // Check if this is the first launch
    bool isFirst = await usersPrefrence.isFirstLaunch();
    
    print("🚀 DEBUG: Is first launch? $isFirst");
    
    if (isFirst) {
      // Mark first launch as complete
      await usersPrefrence.setFirstLaunchComplete();
      print("🚀 DEBUG: Navigating to onboarding flow...");
      // Navigate to onboarding flow after splash
      Timer(
        const Duration(seconds: 3),
        () {
          print("🚀 DEBUG: Timer completed, calling Get.toNamed(onboardingflow)");
          Get.toNamed(RoutesName.onboardingflow);
        },
      );
    } else {
      print("🚀 DEBUG: Not first launch, checking login status...");
      // Check login status for subsequent launches
      isLogin();
    }
  }
  
  void isLogin() {
    usersPrefrence.getUser().then((value) {
      final token = value.token;

      if (token == null || token.isEmpty) {
        Timer(
          const Duration(seconds: 3),
          () => Get.toNamed(RoutesName.loginview),
        );
      } else {
        Timer(
          const Duration(seconds: 3),
          () => Get.toNamed(RoutesName.homeview),
        );
      }
    });
  }
}
