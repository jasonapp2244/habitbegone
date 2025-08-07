import 'package:flutter/material.dart';
import 'package:habitsbegone/resources/colors/app_colors.dart';
import 'package:habitsbegone/utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboradingView3 extends StatefulWidget {
  const OnboradingView3({super.key});

  @override
  State<OnboradingView3> createState() => _OnboradingView3State();
}

class _OnboradingView3State extends State<OnboradingView3> {
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/topbar.png")),
            Text(
              "Included in the program",
              textAlign: TextAlign.center,
              style: GoogleFonts.teachers(
                fontWeight: FontWeight.bold,
                color: AppColors.textBuleColor,
                fontSize: 26,
              ),
            ),
            Row(
              children: [
                Text(
                  "• ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: AppColors.textRedColor,
                  ),
                ),
                Text(
                  "15 Hypnosis Sessions",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textRedColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "• ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: AppColors.textRedColor,
                  ),
                ),
                Text(
                  "15 Weekly Weigh-ins",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textRedColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "• ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: AppColors.textRedColor,
                  ),
                ),
                Text(
                  "15 Weekly Meetings",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textRedColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "• ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: AppColors.textRedColor,
                  ),
                ),
                Text(
                  "15 Weekly Progress Evaluations",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textRedColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '• ',
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.textRedColor,
                    ),
                  ),
                  TextSpan(
                    text:
                        'All necessary forms and reports to keep you on track towards your ideal weight',
                    style: GoogleFonts.inter(
                      color: AppColors.textRedColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text:
                    "And this state-of-the-art APP designed to assist you on your daily journey to the new, improved you!",
                style: GoogleFonts.inter(
                  color: AppColors.textBuleColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ),
            Divider(color: AppColors.skyblue, thickness: 2),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: "\"Success through Awareness, Desire and Opportunity\"",
                style: GoogleFonts.inter(
                  color: AppColors.textBuleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  // fontSize: Responsive.sp(12),
                ),
                // children: [
                //   TextSpan(
                //     text: " Right Amounts ",
                //     style: GoogleFonts.inter(
                //       color: AppColors.textRedColor,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 18,
                //       // fontSize: Responsive.sp(12),
                //     ),
                //   ),
                // ],
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
