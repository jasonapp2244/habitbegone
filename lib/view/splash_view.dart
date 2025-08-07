import 'package:flutter/material.dart';
import 'package:getxmvvm/resources/colors/app_colors.dart';
import 'package:getxmvvm/viewmodel/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    // FOR TESTING: Reset first launch flag to test onboarding flow
    // Comment this out after testing
    splashServices.usersPrefrence.resetFirstLaunch().then((_) {
      splashServices.checkAppState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(   mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/images/app_bar.png")),
                Image(image: AssetImage("assets/images/Frame 1171276849.png")),
              ],
            ),Spacer(),
            Image(image: AssetImage("assets/images/image 7.png")),
          ],
        ),
      ),
    );
  }
}
