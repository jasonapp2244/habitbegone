import 'package:flutter/material.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/viewmodel/services/splash_services.dart';

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
    splashServices.checkAppState();
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/images/app_bar.png")),
                Image(image: AssetImage("assets/images/Frame 1171276850.png")),
              ],
            ),
            Spacer(),
            Image(image: AssetImage("assets/images/image 7.png")),
          ],
        ),
      ),
    );
  }
}
