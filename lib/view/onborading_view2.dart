import 'package:flutter/material.dart';
import 'package:getxmvvm/resources/colors/app_colors.dart';
import 'package:getxmvvm/utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class OborandingView2 extends StatelessWidget {
  const OborandingView2({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/images/topbar.png")),
                Text(
                  "Frustrated with Weight Loss That Doesn't Last?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.teachers(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBuleColor,
                    fontSize: 28,
                  ),
                ),
                Text(
                  "Well this isn't a diet, it's a way of life. A way that through efforts and hypnosis we are able to help change your relationship with food.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textBuleColor,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Before you know it you will be ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textRedColor,
                    fontSize: 18,
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: "1- Eating the",
                    style: GoogleFonts.inter(
                      color: AppColors.textRedColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      // fontSize: Responsive.sp(12),
                    ),
                    children: [
                      TextSpan(
                        text: " Right Foods",
                        style: GoogleFonts.inter(
                          color: AppColors.textRedColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // fontSize: Responsive.sp(12),
                        ),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: "2- In the ",
                    style: GoogleFonts.inter(
                      color: AppColors.textRedColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      // fontSize: Responsive.sp(12),
                    ),
                    children: [
                      TextSpan(
                        text: " Right Amounts ",
                        style: GoogleFonts.inter(
                          color: AppColors.textRedColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // fontSize: Responsive.sp(12),
                        ),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: "3- At the ",
                    style: GoogleFonts.inter(
                      color: AppColors.textRedColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      // fontSize: Responsive.sp(12),
                    ),
                    children: [
                      TextSpan(
                        text: " Right times!",
                        style: GoogleFonts.inter(
                          color: AppColors.textRedColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // fontSize: Responsive.sp(12),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Reaching your Ideal Weight is much easier than you think!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textBuleColor,
                    fontSize: 18,
                  ),
                ),
                Image(image: AssetImage("assets/images/image 12.png")),

                Image(image: AssetImage("assets/images/app_bar.png")),
              ],
            ),
          ),
      
   
    );
  
  }
}
