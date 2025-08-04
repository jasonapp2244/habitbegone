import 'package:flutter/material.dart';
import 'package:getxmvvm/resources/colors/app_colors.dart';
import 'package:getxmvvm/utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class OborandingView extends StatelessWidget {
  const OborandingView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/images/profile.png")),
              Text(
                "Hi, I'm Gary Barone a Certified Hypnotist and I'm pleased to introduce you to HabitsBeGone.com.",
                textAlign: TextAlign.center,
                style: GoogleFonts.dancingScript(
                  color: AppColors.textBuleColor,
                  fontSize: 28,
                ),
              ),
              Text(
                "I've been helping people with various issues since 2011. And now I'd like to help you reach your Ideal Weight through our:",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: AppColors.textBuleColor,
                  fontSize: 18,
                ),
              ),
              Image(image: AssetImage("assets/images/topbar.png")),
              Image(image: AssetImage("assets/images/app_bar.png")),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
