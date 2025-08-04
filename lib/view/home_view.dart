import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getxmvvm/resources/colors/app_colors.dart';
import 'package:getxmvvm/utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Change Your Life with",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.teachers(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColorBlack,
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        "Hypnosis!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.teachers(
                          fontWeight: FontWeight.w400,
                          color: AppColors.skyblue,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset("assets/images/Frame 27.svg"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Responsive.w(45),
                    // width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: AppColors.textBuleColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/Layer_1 (1).svg"),
                          Text(
                            "Hypnotherapy",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.teachers(
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // width: double.infinity,
                    width: Responsive.w(45),
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: AppColors.skyblue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/Layer_1 (2).svg"),
                          Text(
                            "Elec-magnetic Therapy",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.teachers(
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Responsive.w(45),
                    // width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: AppColors.textBuleColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/Layer_1 (4).svg"),
                          Text(
                            "Osteopathy",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.teachers(
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    // width: double.infinity,
                    width: Responsive.w(45),
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: AppColors.skyblue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/Layer_1 (3).svg"),
                          Text(
                            "Osteopathy",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.teachers(
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryColor,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
