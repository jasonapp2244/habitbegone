import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthButton extends StatelessWidget {
  final String? buttontext;
  final bool loading;
  final VoidCallback onPress;
  AuthButton({
    super.key,
    required this.buttontext,
    required this.loading,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          // gradient: AppColors.followButtonGradient,
          color: AppColors.seconadryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              loading
                  ? CustomLoadingAnimation()
                  : Text(
                    buttontext.toString(),
                    style: GoogleFonts.dmSans(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

              SvgPicture.asset("assets/images/Frame 12.svg"),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: Colors.white,
      size: MediaQuery.sizeOf(context).height * 0.02,
    );
  }
}
